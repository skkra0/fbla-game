extends CharacterBody2D

var hp = 10

const bullet_scene = preload("res://enemy_bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater

#edit these for attack patterns
const rotate_speed = 200
const shoot_timer_wait_time = 0.2
const spawn_point_count = 4
const radius = 100

func _ready():	
	if GameState.is_multiplayer:
		hp = 20
		
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
		
	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start() #make it only start in certain cases

func _process(delta):		
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	#THIS DOESNT WORK
	#$Node2D.look_at(player_del)
	if hp <= 0:
		queue_free()

func _on_shoot_timer_timeout():
	for s in rotater.get_children():
		var bullet = bullet_scene.instantiate()
		owner.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation

func _shoot():
	var bullet = bullet_scene.instantiate()
	owner.add_child(bullet)
	bullet.transform = $Node2D/Marker2D.global_transform
	bullet.position = $Node2D/Marker2D.global_position	



func _on_hurtbox_area_entered(area):
	hp -= 1
	area.queue_free()
	print("hit")


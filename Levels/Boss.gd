extends Node
@export var max_hp = 10


@export var rotate_speed = 100
@export var shoot_timer_wait_time = 0.2
@export var spawn_point_count = 4
@export var radius = 100

const bullet_scene = preload("res://Bullets/enemy_bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater
enum {
	SPIRAL
}
var state = SPIRAL
var step = 2 * PI / spawn_point_count
var hp: int

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameState.is_multiplayer:
		max_hp *= 2
	hp = max_hp
	
	$Hurtbox.connect("area_entered", _on_hurtbox_area_entered)
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
	match state:
		SPIRAL:
			for i in range(spawn_point_count):
				var spawn_point = Node2D.new()
				var pos = Vector2(radius, 0).rotated(step * i)
				spawn_point.position = pos
				spawn_point.rotation = pos.angle()
				rotater.add_child(spawn_point)
		
			shoot_timer.wait_time = shoot_timer_wait_time
			shoot_timer.start()
	
func _process(delta):		
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	#THIS DOESNT WORK
	#$Node2D.look_at(player_del)
	if hp <= 0:
		GameState.points += max_hp
		queue_free()

func _on_shoot_timer_timeout():
	for s in rotater.get_children():
		var bullet = bullet_scene.instantiate()
		owner.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation

func _on_hurtbox_area_entered(area):
	hp -= 1
	area.queue_free()

#func _shoot():
#	var bullet = bullet_scene.instantiate()
#	owner.add_child(bullet)
#	bullet.transform = $Node2D/Marker2D.global_transform
#	bullet.position = $Node2D/Marker2D.global_position


extends Node
@export var max_hp = 10


@export var rotate_speed = 100
@export var spiral_wait_time = 0.2
@export var stack_wait_time = 1.5
@export var spiral_spawn_point_count = 4
@export var stack_spawn_count = 3
@export var radius = 100

const bullet_scene = preload("res://Bullets/enemy_bullet.tscn")

@onready var rotater = $SpiralRotator
enum {
	SPIRAL,
	STACK
}
var state = STACK
var spiral_step = 2 * PI / spiral_spawn_point_count
var hp: int

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameState.is_multiplayer:
		max_hp *= 2
	hp = max_hp
	
	$Hurtbox.connect("area_entered", _on_hurtbox_area_entered)
	$SpiralTimer.connect("timeout", _on_spiral_timer_timeout)
	$StackTimer.connect("timeout", _on_stack_timer_timeout)
	match state:
		SPIRAL:
			_spiral_init()
		STACK:
			_stack_init()
			_on_stack_timer_timeout()
	
func _process(delta):
	match state:
		SPIRAL:
			var new_rotation = rotater.rotation_degrees + rotate_speed * delta
			rotater.rotation_degrees = fmod(new_rotation, 360)
		STACK:
			$StackRotator.look_at(get_node("../PlayerDel").position)
	if hp <= 0:
		GameState.points += max_hp
		queue_free()

func _on_spiral_timer_timeout():
	print("timed out")
	if $VisibleOnScreenNotifier2D.is_on_screen():
		match state:
			SPIRAL:
				for s in rotater.get_children():
					var bullet = bullet_scene.instantiate()
					owner.add_child(bullet)
					bullet.position = s.global_position
					bullet.rotation = s.global_rotation
			STACK:
				for s in $StackRotator.get_children():
					var bullet = bullet_scene.instantiate()
					owner.add_child(bullet)
					bullet.position = s.global_position
					bullet.rotation = s.global_rotation
					
func _on_stack_timer_timeout():
	for s in $StackRotator.get_children():
		for i in range(3):
			var bullet = bullet_scene.instantiate()
			bullet.speed = 80 + 20 * i
			owner.add_child(bullet)
			bullet.position = s.global_position
			bullet.rotation = s.global_rotation

func _on_hurtbox_area_entered(area):
	hp -= 1
	area.queue_free()

func _spiral_init():
	for i in range(spiral_spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(spiral_step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	$SpiralTimer.wait_time = spiral_wait_time
	$SpiralTimer.start()
	
func _stack_init():
	var start = -PI / 12
	for i in range(stack_spawn_count):
		var spawn = Node2D.new()
		var pos = Vector2(radius / 2, 0).rotated(start + i * PI / 12)
		spawn.position = pos
		spawn.rotation = pos.angle()
		$StackRotator.add_child(spawn)
	$StackTimer.wait_time = stack_wait_time
	$StackTimer.start()
	

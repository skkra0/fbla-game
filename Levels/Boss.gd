extends Node

enum PATTERNS {
	SPIRAL = 0,
	STACK = 1
}
@export var max_hp = 10

@export var rotate_speed = 100
@export var spiral_wait_time = 0.2
@export var stack_wait_time = 1.2
@export var pattern_change_time = 5
@export var spiral_spawn_point_count = 4
var stack_spawn_count = 3 
@export var radius = 110
@export var base_bullet_speed = 100

@export var state_set : Array[PATTERNS] = []

const bullet_scene = preload("res://Bullets/enemy_bullet.tscn")
@onready var spiral_rotator = $SpiralRotator
@onready var stack_rotator =  $StackRotator

var state_index = 0
var spiral_step = 2 * PI / spiral_spawn_point_count
var hp: int
# Called when the node enters the scene tree for the first time.
func _ready():
	print("setting up boss")
	if GameState.is_multiplayer:
		max_hp *= 2
	hp = max_hp
	
	$Hurtbox.connect("area_entered", _on_hurtbox_area_entered)
	$SpiralTimer.connect("timeout", _on_spiral_timer_timeout)
	$StackTimer.connect("timeout", _on_stack_timer_timeout)
	
	_spiral_init()
	_stack_init()
	if state_set.size() > 1:		
		$PatternTimer.connect("timeout", _on_pattern_timer_timeout)
		$PatternTimer.wait_time = pattern_change_time
		
	
func _process(delta):
	match state_set[state_index]:
		PATTERNS.SPIRAL:
			var new_rotation = spiral_rotator.rotation_degrees + rotate_speed * delta
			spiral_rotator.rotation_degrees = fmod(new_rotation, 360)
		PATTERNS.STACK:
			stack_rotator.look_at(get_node("../PlayerDel").position)
	if hp <= 0:
		GameState.points += max_hp
		queue_free()

func _on_spiral_timer_timeout():
	if $VisibleOnScreenNotifier2D.is_on_screen():
		for s in spiral_rotator.get_children():
			var bullet = bullet_scene.instantiate()
			bullet.position = s.global_position
			bullet.rotation = s.global_rotation
			bullet.speed = base_bullet_speed
			owner.add_child(bullet)
			
			
					
func _on_stack_timer_timeout():
	for s in stack_rotator.get_children():
		for i in range(3):
			var bullet = bullet_scene.instantiate()
			bullet.speed = base_bullet_speed + 10 * i
			bullet.position = s.global_position
			bullet.rotation = s.global_rotation
			owner.add_child(bullet)
			

func _on_hurtbox_area_entered(area):
	hp -= 1
	area.queue_free()

func _spiral_init():
	for i in range(spiral_spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(spiral_step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		spiral_rotator.add_child(spawn_point)
	$SpiralTimer.wait_time = spiral_wait_time
	#$SpiralTimer.start()
	
func _stack_init():
	var start = -PI / 8
	for i in range(stack_spawn_count):
		var spawn = Node2D.new()
		var pos = Vector2(radius / 2.0, 0).rotated(start + i * PI / 8)
		spawn.position = pos
		spawn.rotation = pos.angle()
		stack_rotator.add_child(spawn)
	$StackTimer.wait_time = stack_wait_time
	#$StackTimer.start()
	
func _start():
	if $PatternTimer.is_stopped:
		$PatternTimer.start()
	match state_set[state_index]:
		PATTERNS.SPIRAL:
			$SpiralTimer.start()
		PATTERNS.STACK:
			stack_rotator.look_at(get_node("../PlayerDel").position)
			_on_stack_timer_timeout()
			$StackTimer.start()
	
func reset():
	$SpiralTimer.stop()
	$StackTimer.stop()

func _on_pattern_timer_timeout():
	reset()
	state_index += 1
	state_index %= state_set.size()
	_start()
	

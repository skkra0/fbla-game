extends CharacterBody2D

@export var move_speed : float = 100

const bulletPath = preload('res://Bullet.tscn')

func _ready():
	pass
	
func _process(delta):		
	$Node2D.look_at(get_global_mouse_position())

func _input(event):
	if event.is_action_pressed("ui_accept"):
		shoot()

func shoot():
	var bullet = bulletPath.instantiate()
	
	owner.add_child(bullet)
	bullet.transform = $Node2D/Marker2D.global_transform
	bullet.position = $Node2D/Marker2D.global_position
	

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	var animated_sprite = $AnimatedSprite2D
	if input_direction.x > 0:
		animated_sprite.flip_h = false
	elif input_direction.x < 0:
		animated_sprite.flip_h = true
	
	if (input_direction.length() != 0):
		animated_sprite.play("walk")
	else:
		animated_sprite.stop()
		animated_sprite.frame = 1
	
	velocity = input_direction * move_speed
	move_and_slide()

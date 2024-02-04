extends CharacterBody2D

@export var move_speed : float = 100

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

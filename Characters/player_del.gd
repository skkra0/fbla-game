extends CharacterBody2D
var hp = 10
var can_shoot = true
var can_move = true
var cooldown = 0.1
@export var move_speed : float = 100
const bulletPath = preload('res://PlayerBullet.tscn')

func _ready():
	$Cooldown.wait_time = cooldown
	
func _process(_delta):		
	$Node2D.look_at(get_global_mouse_position())
	
	if hp <= 0:
		queue_free() # remove player

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		shoot()

func shoot():
	if can_shoot:
		can_shoot = false
		$Cooldown.start()
		var bullet = bulletPath.instantiate()
		owner.add_child(bullet)
		bullet.transform = $Node2D/Marker2D.global_transform
		bullet.position = $Node2D/Marker2D.global_position

func _on_cooldown_timeout():
	can_shoot = true

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	var animated_sprite = $AnimatedSprite2D
	if can_move:
		if input_direction.x > 0:
			animated_sprite.flip_h = false
		elif input_direction.x < 0:
			animated_sprite.flip_h = true
		
		if (input_direction.length() != 0):
			animated_sprite.play("walk")
		else:
			animated_sprite.stop()
			animated_sprite.frame = 1
	else:
		animated_sprite.stop()
		animated_sprite.frame = 1
	
	velocity = input_direction * move_speed
	move_and_slide()



func _on_hurtbox_area_entered(area):
	area.queue_free()
	print("shot")
	hp -= 1

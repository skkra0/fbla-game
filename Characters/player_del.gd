extends CharacterBody2D
var hp = 10
var can_shoot = true
var can_move = true
var cooldown = 0.2

@export var move_speed : float = 100
@export var is_player_1 = true

var move_right_action = "right"
var move_left_action = "left"
var move_up_action = "up"
var move_down_action = "down"

const bulletPath = preload('res://Bullets/PlayerBullet.tscn')

func _ready():
	$Cooldown.wait_time = cooldown
	if not is_player_1:
		move_right_action = "right_2"
		move_left_action = "left_2"
		move_up_action = "up_2"
		move_down_action = "down_2"
		modulate = Color(1, 1, 4)

	
func _process(_delta):		
	$Node2D.look_at(get_global_mouse_position())
	
	if hp <= 0:
		self.visible = false
		self.process_mode = Node.PROCESS_MODE_DISABLED
		if is_player_1:
			GameState.player_1_alive = false
		else:
			GameState.player_2_alive = false

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
		Input.get_action_strength(move_right_action) - Input.get_action_strength(move_left_action),
		Input.get_action_strength(move_down_action) - Input.get_action_strength(move_up_action)
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
		
		velocity = input_direction * move_speed
		move_and_slide()
	else:
		animated_sprite.stop()
		animated_sprite.frame = 1



func _on_hurtbox_area_entered(area):
	area.queue_free()
	print("shot")
	hp -= 2

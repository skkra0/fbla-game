extends CharacterBody2D

var active = false
@export var move_speed : float = 100
enum {
	IDLE,
	MOVE
}
var current_state = IDLE
var dir = Vector2.DOWN

func _process(delta):
	match current_state:
		IDLE:
			pass
		MOVE:
			move(delta)
			
func move(delta):
	position += dir * move_speed * delta


func _on_talk_radius_body_entered(body):
	if body.name == "PlayerDel":
		active = true


func _on_talk_radius_body_exited(body):
	if body.name == "PlayerDel":
		active = false

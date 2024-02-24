extends Node2D

var multiplayer_move = "WASD - Move Player 1\nArrow Keys - Move Player 2"
var singleplayer_move = "WASD - Move"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Levels/bedroom/bedroom.tscn")

func _on_check_box_toggled(toggled_on):
	if toggled_on:
		$MoveDesc.text = multiplayer_move
	else:
		$MoveDesc.text = singleplayer_move
	GameState.is_multiplayer = toggled_on

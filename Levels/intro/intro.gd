extends Node2D

var help_menu_open = false

func _ready():
	GameState.reset()

func _input(event):
	if event.is_action_pressed("ui_accept") and help_menu_open:
		$Help.visible = false

func _on_check_box_toggled(toggled_on):
	GameState.is_multiplayer = toggled_on

	


func _on_help_button_down():
	print("help")
	help_menu_open = true
	$Help.visible = true


func _on_play_button_down():
	get_tree().change_scene_to_file("res://Levels/bedroom/bedroom.tscn")

extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	$Score.text = "Score: " + str(GameState.points) + ". Excellent job!"
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Levels/intro.tscn")

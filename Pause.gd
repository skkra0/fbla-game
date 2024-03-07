extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_key_pressed(KEY_P):
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible
		
	if get_tree().paused and event.is_action_pressed("ui_cancel"):
		GameState.reset()
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Levels/intro/intro.tscn")

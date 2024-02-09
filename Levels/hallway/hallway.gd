extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent):
	if Dialogic.current_timeline:
		return
	
	if event.is_action_pressed("ui_accept") and $NPC.active:
		Dialogic.start("hallway")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

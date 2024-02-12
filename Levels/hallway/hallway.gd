extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent):
	if Dialogic.current_timeline:
		return
	
	if event.is_action_pressed("ui_accept") and $NPC.active:
		Dialogic.timeline_ended.connect(unpause)
		$PlayerDel.can_move = false
		$PlayerDel.can_shoot = false
		Dialogic.start("hallway")
		print("hi")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func unpause():
	Dialogic.timeline_ended.disconnect(unpause)
	$PlayerDel.can_move = true
	$PlayerDel.can_shoot = true
	
func _on_boss_trigger_body_entered(body):
	if body == $PlayerDel:
		Dialogic.timeline_ended.connect(start_boss)
		$PlayerDel.can_move = false
		$PlayerDel.can_shoot = false
		Dialogic.start("hallwayboss")


func start_boss():
	Dialogic.timeline_ended.disconnect(start_boss)
	$PlayerDel.can_move = true
	$PlayerDel.can_shoot = true
	$Boss2.visible = true
	$Boss2.process_mode = Node.PROCESS_MODE_INHERIT
	$BossTrigger.process_mode = Node.PROCESS_MODE_DISABLED
	

func _on_boss_2_tree_exited():
	print("gone")
	$Exit.process_mode = Node.PROCESS_MODE_INHERIT


func _on_exit_body_entered(body):
	print("exit entered")
	if body == $PlayerDel:
		get_tree().change_scene_to_file("res://Levels/practice/practice.tscn")

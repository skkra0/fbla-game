extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Dialogic.current_timeline:
		return
		
	if event.is_action_pressed("ui_accept"):
		if $WellSpoken.active:
			$PlayerDel.can_move = false
			$PlayerDel.can_shoot = false
			Dialogic.start("wellspoken")
		elif $Clear.active:
			$PlayerDel.can_move = false
			$PlayerDel.can_shoot = false
			Dialogic.start("clear")
		elif $Change2.active:
			$PlayerDel.can_move = false
			$PlayerDel.can_shoot = false
			Dialogic.start("change2")
		elif $Change.active:
			$PlayerDel.can_move = false
			$PlayerDel.can_shoot = false
			Dialogic.start("change")
		elif $Judgment.active:
			$PlayerDel.can_move = false
			$PlayerDel.can_shoot = false
			Dialogic.start("judgment")
			
		Dialogic.timeline_ended.connect(unpause)

func unpause():
	$PlayerDel.can_move = true
	$PlayerDel.can_shoot = true
	

func _on_boss_trigger_body_entered(body):
	if body == $PlayerDel:
		Dialogic.timeline_ended.connect(start_boss)
		$PlayerDel.can_move = false
		$PlayerDel.can_shoot = false
		Dialogic.start("practiceboss")
	
func start_boss():
	Dialogic.timeline_ended.disconnect(start_boss)
	$PlayerDel.can_move = true
	$PlayerDel.can_shoot = true
	$Boss3.visible = true
	$Boss3.process_mode = Node.PROCESS_MODE_INHERIT
	$BossTrigger.process_mode = Node.PROCESS_MODE_DISABLED

func _on_boss_3_tree_exited():
	print("gone")
	$Exit.process_mode = Node.PROCESS_MODE_INHERIT


func _on_exit_body_entered(body):
	print("exiting practice room..")
	if body == $PlayerDel:
		get_tree().change_scene_to_file("res://Levels/end.tscn")

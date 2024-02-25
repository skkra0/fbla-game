extends "res://Levels/Level.gd"


# Called when the node enters the scene tree for the first time.

func _input(event):
	if Dialogic.current_timeline:
		return
	
	super._input(event)
	
	if event.is_action_pressed("ui_accept"):
		Dialogic.timeline_ended.connect(func(): super.unpause_players(), CONNECT_ONE_SHOT)
		if $WellSpoken.active:
			super.pause_players()
			Dialogic.start("wellspoken")
		elif $Clear.active:
			super.pause_players()
			Dialogic.start("clear")
		elif $Change2.active:
			super.pause_players()
			Dialogic.start("change2")
		elif $Change.active:
			super.pause_players()
			Dialogic.start("change")
		elif $Judgment.active:
			super.pause_players()
			Dialogic.start("judgment")

	
func _on_boss_trigger_body_entered(body):
	if body == $PlayerDel or body == $PlayerDel2:
		Dialogic.timeline_ended.connect(func(): super.start_boss(), CONNECT_ONE_SHOT)
		super.pause_players()
		Dialogic.start("practiceboss")
	


func _on_boss_3_tree_exited():
	$Exit.process_mode = Node.PROCESS_MODE_INHERIT


func _on_exit_body_entered(body):
	if body == $PlayerDel or body == $PlayerDel2:
		var rm = func():
			get_tree().change_scene_to_file("res://Levels/hallway/hallway.tscn")
		rm.call_deferred()

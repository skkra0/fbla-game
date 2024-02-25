extends "res://Levels/Level.gd"

func _on_boss1_tree_exited():
	$Exit.process_mode = Node.PROCESS_MODE_INHERIT # enables the exit

func _on_exit_body_entered(body):
	if body == $PlayerDel or body == $PlayerDel2:
		var rm = func():
			get_tree().change_scene_to_file("res://Levels/hallway/hallway.tscn")
		rm.call_deferred()

func _on_boss_trigger_body_entered(body):
	if body == $PlayerDel or body == $PlayerDel2:
		Dialogic.timeline_ended.connect(func(): super.start_boss(), CONNECT_ONE_SHOT)
		super.pause_players()
		Dialogic.start("bedroom")

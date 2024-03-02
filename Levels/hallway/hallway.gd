extends "res://Levels/Level.gd"
	
func _input(event: InputEvent):
	if Dialogic.current_timeline:
		return
	
	super._input(event)

	if event.is_action_pressed("ui_accept") and $NPC.active:
		Dialogic.timeline_ended.connect(func(): super.unpause_players(), CONNECT_ONE_SHOT)
		super.pause_players()
		Dialogic.start("hallway")
	
func _on_boss_trigger_body_entered(body):
	if body == $PlayerDel or body == $PlayerDel2:
		Dialogic.timeline_ended.connect(func(): super.start_boss(), CONNECT_ONE_SHOT)
		super.pause_players()
		Dialogic.start("hallwayboss")
	
func _on_boss_tree_exited():
	$Exit.process_mode = Node.PROCESS_MODE_INHERIT

func _on_exit_body_entered(body):
	if body == $PlayerDel or body == $PlayerDel2:
		GameState.player_1_hp = $PlayerDel.hp
		GameState.player_2_hp = $PlayerDel2.hp
		var rm = func():
			get_tree().change_scene_to_file("res://Levels/practice/practice.tscn")
		rm.call_deferred()

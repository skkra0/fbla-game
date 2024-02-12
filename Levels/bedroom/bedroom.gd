extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_boss1_tree_exited():
	$Exit.process_mode = Node.PROCESS_MODE_INHERIT # enables the exit

func _on_exit_body_entered(body):
	if body == $PlayerDel:
		get_tree().change_scene_to_file("res://Levels/hallway/hallway.tscn")


func _on_boss_trigger_body_entered(body):
	if body == $PlayerDel:
		Dialogic.timeline_ended.connect(unpause)
		$PlayerDel.can_move = false
		$PlayerDel.can_shoot = false
		Dialogic.start("bedroom")



func unpause():
	Dialogic.timeline_ended.disconnect(unpause)
	$PlayerDel.can_move = true
	$PlayerDel.can_shoot = true
	$Boss1.visible = true
	$Boss1.process_mode = Node.PROCESS_MODE_INHERIT
	$BossTrigger.process_mode = Node.PROCESS_MODE_DISABLED

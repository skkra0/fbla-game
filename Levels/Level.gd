extends Node2D

@export var boss_timeline_name : String
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameState.is_multiplayer:
		$PlayerDel2.process_mode = Node.PROCESS_MODE_INHERIT
		$PlayerDel2.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GameState.has_alive_player():
		$CanvasLayer/HP.update_multiplayer($PlayerDel.hp, $PlayerDel2.hp) if GameState.is_multiplayer else $CanvasLayer/HP.update($PlayerDel.hp)
	else:
		$CanvasLayer/HP.text = "Game Over! Press Enter to try again\nScore: " + str(GameState.points)

func _input(event):
	if event.is_action_pressed("ui_accept") and not GameState.has_alive_player():
		get_tree().change_scene_to_file("res://Levels/intro/intro.tscn")

func _on_boss_trigger_body_entered(body):
	if body == $PlayerDel or body == $PlayerDel2:
		Dialogic.timeline_ended.connect(start_boss)
		pause_players()
		Dialogic.start(boss_timeline_name)

func start_boss():
	Dialogic.timeline_ended.disconnect(start_boss)
	$PlayerDel.can_move = true
	$PlayerDel.can_shoot = true
	$PlayerDel2.can_move = true
	$PlayerDel2.can_shoot = true
	$Boss.visible = true
	$Boss.process_mode = Node.PROCESS_MODE_INHERIT
	$BossTrigger.process_mode = Node.PROCESS_MODE_DISABLED



func pause_players():
	$PlayerDel.can_move = false
	$PlayerDel.can_shoot = false
	$PlayerDel2.can_move = false
	$PlayerDel2.can_shoot = false
	
func unpause_players():
	$PlayerDel.can_move = true
	$PlayerDel.can_shoot = true
	$PlayerDel2.can_move = true
	$PlayerDel2.can_shoot = true

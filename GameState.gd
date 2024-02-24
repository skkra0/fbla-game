extends Node

var is_multiplayer := false
var player_1_alive := true
var player_2_alive := true
var points := 0

func reset():
	is_multiplayer = false
	player_1_alive = true
	player_2_alive = true
	points = 0
	
func has_alive_player():
	return player_1_alive or player_2_alive if is_multiplayer else player_1_alive

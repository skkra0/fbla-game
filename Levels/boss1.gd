extends CharacterBody2D

var hp = 10

func _process(_delta):		
	if hp <= 0:
		queue_free() # remove player

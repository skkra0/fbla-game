extends CharacterBody2D

var speed = 300

func _physics_process(delta):
	position += transform.x * speed * delta


extends Node2D

var speed = 100

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_KillTimer_timeout() -> void:
	queue_free()

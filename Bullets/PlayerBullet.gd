extends Node2D

var speed = 300

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("bullet deleted")
	queue_free()

extends CharacterBody2D

var speed = 300

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_VisibleOnScreenNotifier2D_screen_exited():
	queue_free()

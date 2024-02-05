extends Area2D

var speed = 300

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_VisibleOnScreenNotifier2D_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.name == "Boss1":
		body.hp -= 1
		print("HIT!")
		queue_free()

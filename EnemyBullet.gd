extends Area2D

var speed = 100

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_VisibleOnScreenNotifier2D_screen_exited():
	queue_free()

func _on_body_entered(body):
	#if body.name == "PlayerDel":
	#	body.hp -= 1
	#	print("Youch!")
	#	queue_free()
	pass

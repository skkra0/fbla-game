extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_as_top_level(true)
	self.set_position(Vector2(5, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.text = "HP: " + str(get_parent().hp)

extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_as_top_level(true)
	self.set_position(Vector2(5, 0))

	
func update(player_hp):
	self.text = "Player HP: " + str(player_hp)
	
func update_multiplayer(p1_hp, p2_hp):
	self.text = "Player 1 HP: " + str(p1_hp) + "\nPlayer 2 HP: " + str(p2_hp)

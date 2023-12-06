extends Control
var experience = 0

signal get_exp(amount)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_enemy_drop_exp(amount):
	$Player.get_exp(amount)



func _on_enemy_drop_gold(amount):
	$Player.get_gold(amount)

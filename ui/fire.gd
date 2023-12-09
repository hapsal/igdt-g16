extends Node2D

var SPEED = 30
var FRICTION = 15
var SHIFT_DIRECTION:  Vector2 = Vector2.ZERO
var label_node: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	label_node = $Fire
	SHIFT_DIRECTION = Vector2(randf_range(2,-2), randf_range(2,-2))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += SPEED * SHIFT_DIRECTION * delta
	SPEED = max(SPEED - FRICTION * delta, 0)
	pass



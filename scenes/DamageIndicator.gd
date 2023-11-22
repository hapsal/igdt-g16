extends Node2D

var SPEED = 30
var FRICTION = 15
var SHIFT_DIRECTION:  Vector2 = Vector2.ZERO
var label_node: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	label_node = $Label
	SHIFT_DIRECTION = Vector2(randf_range(-1,1), randf_range(-1,1))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += SPEED * SHIFT_DIRECTION * delta
	SPEED = max(SPEED - FRICTION * delta, 0)
	pass



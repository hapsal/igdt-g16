extends CharacterBody2D
class_name PlayerCharacter

const SPEED = 300
var velocity_vector = Vector2.ZERO
var anim_sprite: AnimatedSprite2D  # Reference to the AnimatedSprite2D node

func _ready():
	# Get a reference to the AnimatedSprite2D node
	anim_sprite = $AnimatedSprite2D
	anim_sprite.play("front_walk") 

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	# Reset the velocity vector before checking input
	velocity_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		velocity_vector.x += SPEED
		anim_sprite.play("right_walk")
	if Input.is_action_pressed("ui_left"):
		velocity_vector.x -= SPEED
		anim_sprite.play("left_walk")
	if Input.is_action_pressed("ui_down"):
		velocity_vector.y += SPEED
		anim_sprite.play("front_walk")
	if Input.is_action_pressed("ui_up"):
		velocity_vector.y -= SPEED
		anim_sprite.play("front_walk")

	velocity = velocity_vector  # Set the character's velocity based on the input

	if velocity_vector == Vector2.ZERO:
		anim_sprite.stop()  # Stop the animation when no movement input

	move_and_slide()

extends CharacterBody2D

const SPEED = 600
const ACCELERATION = 500
#const FRICTION = 500

func _physics_process(delta):
	# movement of the player
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		#moves smoothly
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION * delta)
		
		#velocity = input_vector * SPEED

	else:
		velocity = Vector2.ZERO
		# stops smoothly
		#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move_and_slide()

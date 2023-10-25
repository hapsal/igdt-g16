extends CharacterBody2D

const SPEED = 200

func _physics_process(delta):
	# Find the player character
	var player = get_node("/root/UI/CharacterBody2D")

	if player:
		# Calculate the direction to the player
		var direction = (player.global_position - global_position).normalized()

		# Move towards the player
		velocity = direction * SPEED

	move_and_slide()

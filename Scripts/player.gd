extends CharacterBody2D

# Combat system variables
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_in_progress = false

# General movement variables
const SPEED = 300
var velocity_vector = Vector2.ZERO
var anim_sprite: AnimatedSprite2D  # Reference to the AnimatedSprite2D node

func _ready():
	anim_sprite = $AnimatedSprite2D # Get a reference to the AnimatedSprite2D node
	anim_sprite.play("front_walk") 

func _physics_process(delta):
	player_movement(delta) 
	enemy_attack()
	
	if health <= 0:
		player_alive = false  # Player dies from too much damage
		health = 0
		print("Game over, you died!")
		self.queue_free()
	
func player_movement(delta):
	# Reset the velocity vector before checking input
	velocity_vector = Vector2.ZERO
	
# Basic movement statements
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
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_in_progress = true
		# Add an animated sprite for attacks here
		$deal_attack_timer.start()
		
	move_and_slide()


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true
	
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func player():
	pass

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$attack_cooldown.start() 
		print("player health is ", health)

func _on_attack_cooldown_timeout(): 
	enemy_attack_cooldown = true


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_in_progress = false

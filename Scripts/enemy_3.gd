extends CharacterBody2D

var speed = 150
var player_chase = false
var player = null
var health = 100
var player_in_attack_zone = false
var can_take_damage = true
var combat_system

signal drop_exp(amount)
signal drop_gold(amount)

func _ready():
	
	set_health_label()
	

func _physics_process(_delta):
	deal_with_damage()
	
	if player_chase:
		var direction_to_player = player.position - position
		var x_difference = abs(direction_to_player.x)
		var y_difference = abs(direction_to_player.y)

		if x_difference > y_difference:
			if direction_to_player.x < 0:
				$AnimatedSprite2D.play("left_walk")
			else:
				$AnimatedSprite2D.play("right_walk")
		else:
			if direction_to_player.y < 0:
				$AnimatedSprite2D.play("back_walk")
			else:
				$AnimatedSprite2D.play("front_walk")
		position += direction_to_player.normalized() * speed * _delta
	else:
		$AnimatedSprite2D.play("idle")


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	
func enemy():
	pass

func deal_with_damage():
	if player_in_attack_zone and Global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 10
			spawn_dmgIndicator(10)
			$take_damage_cooldown.start()
			can_take_damage = false
			print("pumpkin health is ", health)
			set_health_label()
			if health <= 0: 
				give_experience()
				give_gold()
				await get_tree().create_timer(2).timeout
				get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn")
				self.queue_free()

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone = false


func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func spawn_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position, offset: Vector2 = Vector2.ZERO):
		if EFFECT:
			
			var effect = EFFECT.instantiate()
			effect.global_position = effect_position + offset  # Applying offset to the position
			get_tree().current_scene.add_child(effect)
			
			return effect 
			
func spawn_dmgIndicator(damage: int):
	var INDICATOR_DAMAGE = preload("res://ui/enemy_damage_indicator.tscn")
	var indicator = spawn_effect(INDICATOR_DAMAGE, global_position, Vector2(60, -40))
	if indicator:
		indicator.label_node.text = "- " + str(damage)
		
func set_health_label() -> void:
	$HealthLabel.value = health
	
func give_experience():
	drop_exp.emit(60)
	
func give_gold():
	drop_gold.emit(120)


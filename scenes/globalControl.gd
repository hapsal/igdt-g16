extends Control
var experience = 0
var musicChanged = false
var has_money = false
var has_sword = false

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


func _on_player_new_player_level(level):
	get_tree().call_group("Enemies", "set_player_level")


func _on_mainboss_drop_gold(amount):
	$Player.get_exp(amount)


func _on_mainboss_drop_exp(amount):
	$Player.get_gold(amount)


func _on_music_change_body_entered(body):
	if body.has_method("player"):
			# Change the background music when the player enters
			var background_music = $MusicPlayer # Replace "YourNodePath" with the actual path to your AudioStreamPlayer node
			if background_music and musicChanged!=true:
				musicChanged = true
				background_music.stream = load("res://assets/audio/music/battle_music.wav")  # Replace with the path to your new music file
				background_music.play()  # Play the new music

func sword_buy():
	has_sword = true
	$Player.sword_bought()




func _on_player_has_gold(gold):
	has_money = true

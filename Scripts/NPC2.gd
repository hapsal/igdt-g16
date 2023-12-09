extends Area2D

var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_NPC_body_entered)
	body_exited.connect(_on_NPC_body_exited)
	pass # Replace with function body.

func _on_NPC_body_entered(body):
		active = true


func _on_NPC_body_exited(body):
		active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Indicator.visible = active
	if active == true && Input.is_action_just_pressed("Interact") == true:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue.dialogue"),"start")
		return
	pass

extends Area2D

var is_dialog_active = false
var active = false

signal dialogue_started
# Called when the node enters the scene tree for the first time.
func _ready()	:
	body_entered.connect(_on_NPC_body_entered)
	body_exited.connect(_on_NPC_body_exited)
	
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	pass # Replace with function body.

func _on_NPC_body_entered(body):
	if body.has_method("player"):
		active = true


func _on_NPC_body_exited(body):
	if body.has_method("player"):
		active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Indicator.visible = active
	if active == true && Input.is_action_just_pressed("Interact") == true && is_dialog_active == false:
		is_dialog_active = true;
		dialogue_started.emit()
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue.dialogue"),"start")
		return
	pass
func _on_dialogue_ended(_resource: DialogueResource):
	is_dialog_active = false

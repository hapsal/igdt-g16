extends Node2D


# This will be changed later to different scene
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/ui.tscn")


func _on_quit_pressed():
	get_tree().quit()

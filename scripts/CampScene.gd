extends Node

func _ready():
	var back_button = get_node("BackButton")
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

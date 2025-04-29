extends Node

func _ready():
	Dialogic.start("Campsite")
	var back_button = get_node("HBoxContainer/BackButton")
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

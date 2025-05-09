extends Node

func _ready():
	Dialogic.start("barkeep")
	var back_button = get_node("HBoxContainer/BackButton")
	var play_button = get_node("HBoxContainer/Play")
	back_button.pressed.connect(_on_back_button_pressed)
	play_button.pressed.connect(_on_play_pressed)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Shadowjack/shadowjack.tscn")

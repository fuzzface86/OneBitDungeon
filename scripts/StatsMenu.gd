extends Control

func _ready():
	var back_button = get_node("BackButton")
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed():
	var tree = get_tree()
	var backpack_scene = load("res://scenes/Backpack.tscn") # adjust if needed
	tree.change_scene_to_packed(backpack_scene)

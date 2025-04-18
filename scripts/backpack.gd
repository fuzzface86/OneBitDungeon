extends Control

func _ready():
	var button_paths = {
		"CenterContainer/VBoxContainer/StatsButton": _on_stats_button_pressed,
		"CenterContainer/VBoxContainer/BackButton": _on_back_button_pressed
	}

	for path in button_paths.keys():
		var button = get_node_or_null(path)
		if button:
			button.pressed.connect(button_paths[path])
		else:
			print("Button not found: ", path)

func _on_stats_button_pressed():
	var stats_scene = load("res://scenes/StatsMenu.tscn")
	if stats_scene:
		get_tree().change_scene_to_packed(stats_scene)
	else:
		push_error("Failed to load StatsMenu.tscn")

func _on_back_button_pressed():
	var main_scene = load("res://scenes/main.tscn") # Adjust if needed
	if main_scene:
		get_tree().change_scene_to_packed(main_scene)
	else:
		push_error("Failed to load main.tscn")

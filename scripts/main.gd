extends Node

func _ready():
	# 🔁 Existing button connection code
	var button_paths = {
		"HBoxContainer/BackpackButton": _on_backpack_button_pressed,
		"HBoxContainer/GameButton": _on_game_button_pressed,
		"HBoxContainer/TavernButton": _on_tavern_button_pressed,
		"HBoxContainer/CampButton": _on_camp_button_pressed,
	}

	for path in button_paths.keys():
		var button = get_node_or_null(path)
		if button:
			button.pressed.connect(button_paths[path])
		else:
			print("Button not found: ", path)

func _on_backpack_button_pressed():
	_load_scene("res://scenes/Backpack.tscn")

func _on_game_button_pressed():
	_load_scene("res://src/Battle.tscn")

func _on_tavern_button_pressed():
	_load_scene("res://scenes/TavernScene.tscn")

func _on_camp_button_pressed():
	_load_scene("res://scenes/CampScene.tscn")

func _load_scene(path: String):
	var scene = load(path)
	if scene == null:
		push_error("Failed to load scene at: " + path)
		return

	var new_scene = scene.instantiate()

	var tree = get_tree()
	var current = tree.current_scene
	if current:
		current.queue_free()

	tree.root.add_child(new_scene)
	tree.current_scene = new_scene

extends Node

func _ready():
	# ✅ PATCH: Assign global hero stats from Hero scene
	var hero_node = $Hero  # Replace if it's named something else in the scene
	if hero_node:
		var character_stats_node = hero_node.get_node_or_null("CharacterStats")  # Or use "." if attached to Hero
		if character_stats_node:
			HeroData.set_hero_stats(character_stats_node)
			print("✅ Hero stats assigned globally.")
		else:
			push_warning("⚠️ CharacterStats node not found in Hero.")
	else:
		push_warning("⚠️ Hero node not found in scene.")

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
	_load_scene("res://scenes/DungeonGame.tscn")

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

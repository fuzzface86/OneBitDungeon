extends Node

var enemy_scenes = [
	preload("res://enemies/Rat.tscn"),
	preload("res://enemies/Goblin.tscn"),
	preload("res://enemies/Beholder.tscn")
]

var current_enemy = null
var enemy_pool = []

func _ready():
    for scene in enemy_scenes:
        var instance = scene.instantiate()
        enemy_pool.append(instance)

func _ready():
	# Button hookup
	$BattleOptions/AttackButton.pressed.connect(_on_attack_pressed)
	$BattleOptions/UseItemButton.pressed.connect(_on_use_item_pressed)
	$BattleOptions/RunButton.pressed.connect(_on_RunButton_pressed)
	$BattleOptions/MagicButton.pressed.connect(_on_special_pressed)

	# Spawn enemy
	load_random_enemy()

func load_random_enemy():
	if current_enemy:
		current_enemy.queue_free()

	var random_index = randi() % enemy_scenes.size()
	var scene = enemy_scenes[random_index]
	current_enemy = scene.instantiate()

	# 💡 Scale enemy based on hero level
	var hero_stats = HeroData.get_hero_stats()
	if hero_stats and current_enemy.has_method("scale_to_level"):
		current_enemy.scale_to_level(hero_stats.level)

	# Add enemy to display holder
	var enemy_sprite_holder = $EnemySprite
	enemy_sprite_holder.add_child(current_enemy)
	current_enemy.position = Vector2.ZERO

	# Update UI labels
	if current_enemy.has_method("get_enemy_name"):
		$EnemyUI/EnemyName.text = current_enemy.get_enemy_name()
	else:
		$EnemyUI/EnemyName.text = "Unknown Enemy"

	if current_enemy.has_method("get_hp_display"):
		$EnemyUI/EnemyHP.text = current_enemy.get_hp_display()
	else:
		$EnemyUI/EnemyHP.text = "HP: ???"

# === Button Handlers ===
func _on_use_item_pressed():
	print("Use item selected!")

func _on_RunButton_pressed():
	print("Run selected!")
	var tree = get_tree()
	var main_scene = load("res://scenes/main.tscn")  # make sure the path is correct
	tree.change_scene_to_packed(main_scene)
	
func _on_special_pressed():
	print("Special selected!")

func update_enemy_ui():
	if current_enemy and is_instance_valid(current_enemy):
		if current_enemy.has_method("get_enemy_name"):
			$EnemyUI/EnemyName.text = current_enemy.get_enemy_name()
		if current_enemy.has_method("get_hp_display"):
			$EnemyUI/EnemyHP.text = current_enemy.get_hp_display()

func _on_attack_pressed():
	if not current_enemy or not HeroData.get_hero_stats():
		return

	var hero = HeroData.get_hero_stats()
	var damage = 1

	if current_enemy.has_method("take_damage"):
		damage = current_enemy.take_damage(hero.attack)
		print("Hero dealt %d damage" % damage)

	# Check if enemy survived
	if is_instance_valid(current_enemy):
		update_enemy_ui()

		# Wait briefly before enemy strikes back
		await get_tree().create_timer(0.5).timeout
		enemy_attack()
	else:
		enemy_defeated()

func enemy_attack():
	if not current_enemy or not current_enemy.has("attack"):
		return

	var enemy_attack = current_enemy.attack
	var hero = HeroData.get_hero_stats()
	hero.hp -= enemy_attack
	hero.hp = max(hero.hp, 0)

	print("%s attacks for %d damage!" % [current_enemy.get_enemy_name(), enemy_attack])
	$PlayerUI/PlayerHP.text = "HP: %d / %d" % [hero.hp, hero.max_hp]

	if hero.hp <= 0:
		print("You have been defeated!")
		# Optional: Add a Game Over transition here

func enemy_defeated():
	print("Enemy defeated!")
	$EnemyUI/EnemyHP.text = "Enemy defeated!"
	await get_tree().create_timer(1.0).timeout
	load_random_enemy()

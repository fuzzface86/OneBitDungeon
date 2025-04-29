extends Control

signal textbox_closed

@export var enemy: Resource = null

var current_player_health = 0
var current_enemy_health = 0
var is_defending = false

var ENEMIES = [
	preload("res://enemies/rat.tres"),
	preload("res://Enemies/goblin.tres"),
	preload("res://Enemies/orc.tres"),
	preload("res://Enemies/beholder.tres"),
	preload("res://Enemies/knight.tres"),
	preload("res://Enemies/crab.tres"),
	preload("res://Enemies/cyclops.tres"),
	preload("res://Enemies/mage.tres"),
	preload("res://Enemies/mimic.tres"),
	preload("res://Enemies/minotaur.tres"),
	preload("res://Enemies/skeleton.tres"),
	preload("res://Enemies/sludge.tres"),
	preload("res://Enemies/snake.tres"),
	preload("res://Enemies/spider.tres"),
	preload("res://Enemies/wolf.tres"),
	preload("res://Enemies/zombie.tres")
]

func _ready():
	State.leveled_up.connect(_on_hero_leveled_up)
	
	enemy = ENEMIES.pick_random()
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$Enemy.texture = enemy.texture

	
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("A wild %s appears!" % enemy.name.to_upper())
	await self.textbox_closed
	$ActionsPanel.show()

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]

func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$ActionsPanel.hide()
	$Textbox.show()
	$Textbox/Label.text = text

func enemy_turn():
	display_text("%s launches at you fiercely!" % enemy.name)
	await self.textbox_closed
	
	if is_defending:
		is_defending = false
		$AnimationPlayer.play("mini_shake")
		await $AnimationPlayer.animation_finished
		display_text("You defended successfully!")
		await self.textbox_closed
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("shake")
		await $AnimationPlayer.animation_finished
		display_text("%s dealt %d damage!" % [enemy.name, enemy.damage])
		await self.textbox_closed
	$ActionsPanel.show()

func _on_Run_pressed():
	display_text("Got away safely!")
	await self.textbox_closed
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_Attack_pressed():
	display_text("You swing your piercing sword!")
	await self.textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - State.strength)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)

	$AnimationPlayer.play("enemy_damaged")
	await $AnimationPlayer.animation_finished
	
	display_text("You dealt %d damage!" % State.strength)
	await self.textbox_closed
	
	if current_enemy_health == 0:
		display_text("%s was defeated!" % enemy.name)
		await self.textbox_closed

		State.gain_exp(enemy.xp_reward)
		display_text("You gained %d EXP!" % enemy.xp_reward)
		await self.textbox_closed

		var gold_reward = randi() % (enemy.enemy_gold + 1)
		State.gold += gold_reward
		display_text("You gained %d gold!" % gold_reward)
		await self.textbox_closed

		$AnimationPlayer.play("enemy_died")
		await $AnimationPlayer.animation_finished
	
		await get_tree().create_timer(0.25).timeout
		get_tree().change_scene_to_file("res://scenes/main.tscn")

	enemy_turn()

func _on_Defend_pressed():
	is_defending = true
	
	display_text("You prepare defensively!")
	await self.textbox_closed
	
	await get_tree().create_timer(0.25).timeout
	
	enemy_turn()

func _on_hero_leveled_up():
	display_text("LEVEL UP! You are now Level %d!" % State.level)
	await self.textbox_closed

extends Control

@onready var health_label: Label = $VBoxContainer/HPLabel
@onready var back_button: Button = $BackButton
@onready var xp_label: Label = $box1/XPLabel
@onready var str_label: Label = $VBoxContainer/StrLabel  # (Make sure it's spelled exactly!)
@onready var level_label: Label = $box1/LevelLabel
@onready var gold_label: Label = $VBoxContainer/Gold
@onready var magic_label: Label = $VBoxContainer/MPLabel
@onready var defense_label: Label = $VBoxContainer/Defense

func _ready():
	update_level_display()
	update_health_display()
	update_xp_display()
	update_dmg_display()
	update_gold_label()
	update_magic_label()
	update_defense_label()
	back_button.pressed.connect(_on_BackButton_pressed)

func update_level_display():
	level_label.text = "Level: %d" % State.level
func update_health_display():
	health_label.text = "Health: %d / %d" % [State.current_health, State.max_health]

func update_xp_display():
	xp_label.text = "XP: %d" % State.current_exp

func update_dmg_display():
	str_label.text = "STR: %d" % State.strength

func update_gold_label():
	gold_label.text = "Gold: %d" % State.gold
	
func  update_magic_label():
	magic_label.text = "MP: %d/%d" % [State.current_magic, State.max_magic]

func update_defense_label():
	defense_label.text = "DEF: %d" % State.defense
	
func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

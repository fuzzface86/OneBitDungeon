extends Control

var hero_stats = {
	"name": "Snaggy Missingtooth",
	"level": 1,
	"xp": 0,
	"xp_required": 200,
	"hp": 45,
	"max_hp": 60,
	"mp": 12,
	"strength": 8,
	"defense": 6,
	"agility": 10,
	"luck": 5,
	"gold": 13,
}

func _ready():
	update_stats_display()
	var back_button = get_node("BackButton")
	back_button.pressed.connect(_on_back_button_pressed)

func update_stats_display():
	get_node("Name").text = hero_stats["name"]
	get_node("Level").text = "Lvl: %d" % hero_stats["level"]
	get_node("XP").text = "XP: %d/%d" % [hero_stats["xp"], hero_stats["xp_required"]]
	get_node("HP").text = "HP: %d/%d" % [hero_stats["hp"], hero_stats["max_hp"]]
	get_node("MP").text = "MP: %d" % hero_stats["mp"]
	get_node("Strength").text = "STR: %d" % hero_stats["strength"]
	get_node("Defense").text = "DEF: %d" % hero_stats["defense"]
	get_node("Agility").text = "Agility: %d" % hero_stats["agility"]
	get_node("Luck").text = "Luck: %d" % hero_stats["luck"]
	get_node("Gold").text = "Gold: %d" % hero_stats["gold"]

func _on_back_button_pressed():
	var tree = get_tree()
	var backpack_scene = load("res://scenes/Backpack.tscn") # adjust if needed
	tree.change_scene_to_packed(backpack_scene)

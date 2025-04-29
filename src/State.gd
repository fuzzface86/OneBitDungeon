extends Node

signal leveled_up

var hero_name: String = "Hero"
var level: int = 1
var current_health: int = 35
var max_health: int = 35
var gold: int = 3
var strength: int = 5
var current_magic: int = 5
var max_magic: int = 5
var defense: int = 1
var current_exp: int = 0
var exp_total: int = 0
var exp_required: int = get_required_exp(level + 1)

# -- CALCULATE how much XP needed for NEXT level
func get_required_exp(level: int) -> int:
	var xp_table = [0, 300, 900, 2700, 6500, 14000, 23000, 34000, 48000, 64000]
	if level - 1 < xp_table.size():
		return xp_table[level - 1]
	else:
		return 100000 + (level - 10) * 10000 # After level 10, slow gains


# -- When the hero gains experience
func gain_exp(amount: int) -> void:
	exp_total += amount
	current_exp += amount
	while current_exp >= exp_required:
		current_exp -= exp_required
		level_up()

# -- LEVEL UP function
func level_up() -> void:
	level += 1
	exp_required = get_required_exp(level + 1)

	var stats = ['max_health', 'strength', 'max_magic', 'defense']
	var random_stat = stats[randi() % stats.size()]
	set(random_stat, get(random_stat) + (randi() % 4) + 2)
	
	current_health = max_health
	current_magic = max_magic

	print("LEVEL UP! Now level %d" % level)

	emit_signal("leveled_up") # <-- This line is NEW

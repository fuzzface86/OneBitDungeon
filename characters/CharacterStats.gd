# CharacterStats.gd
extends Node2D
class_name CharacterStats

# === Basic Info ===
@export var character_name: String = "Hero"
@export var level: int = 1
@export var xp: int = 0
@export var gold: int = 0

# === Stats ===
@export var max_hp: int = 20
@export var current_hp: int = 20
@export var attack: int = 5
@export var defense: int = 2
@export var speed: int = 3

# === XP Thresholds (inspired by D&D, stretched for longer grind)
var xp_thresholds := [
	0, 100, 300, 700, 1500, 3000, 6000, 9500, 13500, 18000,
	23000, 29000, 36000, 45000, 55000, 66000, 78000, 91000, 105000, 120000
]

# === XP & Leveling Methods ===

func gain_xp(amount: int) -> void:
	xp += amount
	print("Gained %d XP (Total: %d)" % [amount, xp])
	check_level_up()

func check_level_up() -> void:
	while level < xp_thresholds.size() and xp >= xp_thresholds[level]:
		level += 1
		print("🎉 Leveled Up! Now Level %d" % level)
		apply_level_up_bonus()

func xp_to_next_level() -> int:
	if level < xp_thresholds.size():
		return xp_thresholds[level] - xp
	return 0  # Already max level

func apply_level_up_bonus() -> void:
	# Customize these growth values however you'd like
	max_hp += 5
	attack += 1
	defense += 1
	speed += 1
	current_hp = max_hp  # Restore HP on level up
	print("Stats increased! New stats → HP: %d | ATK: %d | DEF: %d | SPD: %d" %
		[max_hp, attack, defense, speed])

# === Combat Methods ===
func take_damage(amount: int) -> int:
	var damage = max(amount - defense, 1)
	current_hp = max(current_hp - damage, 0)
	return damage

func heal(amount: int) -> void:
	current_hp = min(current_hp + amount, max_hp)

func is_dead() -> bool:
	return current_hp <= 0

# res://enemies/Beholder.gd
extends Node2D
class_name Beholder

@export var stats: EnemyStats

var level := 1
var max_hp := 30
var current_hp := 30
var attack := 0
var defense := 0
var speed := 0
var xp_reward := 20
var gold_reward := 15
var loot_table := {
	"eye_stalk": 0.4,
	"magic_gem": 0.2,
	"ancient_tome": 0.1
}

# Base stats
const BASE_HP := 30
const BASE_ATK := 8
const BASE_DEF := 5
const BASE_SPD := 3

func scale_to_level(hero_level: int):
	level = clamp(hero_level, 5, 30)
	max_hp = BASE_HP + (level * 5)
	attack = BASE_ATK + int(level * 1.5)
	defense = BASE_DEF + int(level)
	speed = BASE_SPD + int(level / 4)
	current_hp = max_hp

func get_enemy_name() -> String:
	return "Beholder Lv: %d" % level

# 🔹 And this
func get_hp_display() -> String:
	return "HP: %d/%d" % [current_hp, max_hp]

func take_damage(amount: int) -> int:
	var damage = max(amount - stats.defense, 1)
	stats.current_hp = max(stats.current_hp - damage, 0)

	if stats.current_hp <= 0:
		die()

	return damage

func die():
	print("%s defeated!" % stats.name)
	queue_free()

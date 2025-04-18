# res://enemies/Goblin.gd
extends Node2D
class_name Goblin

@export var stats: EnemyStats

var level := 1
var max_hp := 10
var current_hp := 10
var attack := 0
var defense := 0
var speed := 0
var xp_reward := 6
var gold_reward := 4
var loot_table := {
	"dagger": 0.3,
	"goblin_ear": 0.5
}

# Base stats
const BASE_HP := 10
const BASE_ATK := 4
const BASE_DEF := 2
const BASE_SPD := 4

func scale_to_level(hero_level: int):
	level = clamp(hero_level, 1, 15)
	max_hp = BASE_HP + (level * 3)
	attack = BASE_ATK + int(level * 1.2)
	defense = BASE_DEF + int(level / 2)
	speed = BASE_SPD + int(level / 2)
	current_hp = max_hp

func get_enemy_name() -> String:
	return "Goblin Lv: %d" % level

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

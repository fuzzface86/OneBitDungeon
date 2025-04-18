extends Node
class_name EnemyStats

@export var stats_resource: Resource  # Should be of type EnemyData

var name: String
var level: int
var max_hp: int
var hp: int
var attack: int

func _ready():
	_init_stats_from_resource()

func _init_stats_from_resource():
	if stats_resource == null:
		push_warning("EnemyStats: stats_resource is not set.")
		return

	if stats_resource.has_method("get"):
		name = stats_resource.name
		level = stats_resource.level
		max_hp = stats_resource.max_hp
		hp = max_hp
		attack = stats_resource.attack
	else:
		push_error("EnemyStats: stats_resource is missing required fields.")

func scale_to_level(hero_level: int):
	# Future-proof: don't overwrite base values; scale relatively
	level = hero_level
	max_hp = stats_resource.max_hp + (hero_level * 2)
	hp = max_hp
	attack = stats_resource.attack + hero_level

func take_damage(amount: int) -> int:
	hp -= amount
	if hp <= 0:
		hp = 0
		die()
	return amount

func die():
	queue_free()  # Consider playing death animation or spawning loot before freeing

func get_enemy_name() -> String:
	return name

func get_hp_display() -> String:
	return "HP: %d / %d" % [hp, max_hp]

extends Node2D
class_name BaseEnemy

@onready var stats: EnemyStats = $EnemyStats

func _ready():
	if stats and stats.has_method("scale_to_level"):
		var hero_stats = HeroData.get_hero_stats()
		stats.scale_to_level(hero_stats.level)

func get_enemy_name() -> String:
	return "%s Lv: %d" % [stats.name, stats.level]

func get_hp_display() -> String:
	return stats.get_hp_display()

func take_damage(amount: int) -> int:
	if not stats:
		return 0

	var damage = stats.take_damage(amount)
	if stats.hp <= 0:
		die()
	return damage

func die():
	print("%s defeated!" % stats.name)
	queue_free()  # Replace this with animation/sound logic if needed

extends Node2D

@export var base_stats: Resource

func _ready():
	if base_stats:
		$Sprite2D.texture = base_stats.texture

# HeroData.gd
extends Node

# This holds a reference to the active character stats script
var character_stats: Node = null
var inventory = []
var gold = 0
var current_quest = null

func set_hero_stats(stats_node: Node) -> void:
	character_stats = stats_node

func get_hero_stats() -> Node:
	return character_stats

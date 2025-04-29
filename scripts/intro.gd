extends Node2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	await anim_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")

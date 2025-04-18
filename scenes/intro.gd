extends Control

@onready var scroll_label = $ScrollContainer/Label

var scroll_speed = 30
var scroll_finished = false

func _ready():
	scroll_label.rotation_degrees = -12 # for a tilted crawl
	scroll_label.scale = Vector2(1.2, 1.2) # optional perspective
	scroll_label.anchor_left = 0.5
	scroll_label.anchor_right = 0.5
	scroll_label.pivot_offset = scroll_label.size / 2
	scroll_label.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y + 50)

func _process(delta):
	if scroll_finished:
		return

	scroll_label.position.y -= scroll_speed * delta

	if scroll_label.position.y + scroll_label.size.y < 0:
		scroll_finished = true
		# Transition to next scene here
		get_tree().change_scene_to_file("res://DungeonGame.tscn")

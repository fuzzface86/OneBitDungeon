extends Node2D

@export var walk_bounds := Vector2(100, 400)
@export var walk_speed := 30.0
@export var idle_chance := 0.4
@export var idle_duration_range := Vector2(1.0, 2.5)

@onready var sprite := $AnimatedSprite2D

var direction := 1
var is_idle := false
var idle_timer := 0.0

func _ready():
	randomize()
	choose_idle_randomly()
	sprite.flip_h = direction < 0
	update_animation()

func _process(delta):
	if not sprite:
		print("Sprite not found!")
		return

	if is_idle:
		idle_timer -= delta
		if idle_timer <= 0:
			is_idle = false
			update_animation()
	else:
		position.x += direction * walk_speed * delta

		if position.x <= walk_bounds.x:
			position.x = walk_bounds.x
			direction = 1
			sprite.flip_h = false
			choose_idle_randomly()

		elif position.x >= walk_bounds.y:
			position.x = walk_bounds.y
			direction = -1
			sprite.flip_h = true
			choose_idle_randomly()

		update_animation()

func choose_idle_randomly():
	if randf() < idle_chance:
		is_idle = true
		idle_timer = randf_range(idle_duration_range.x, idle_duration_range.y)
		update_animation()

func update_animation():
	if not sprite:
		return

	var new_animation = "idle" if is_idle else "walk"

	if sprite.animation != new_animation:
		sprite.play(new_animation)
		print("Switching to animation:", new_animation)

extends AnimatedSprite2D

enum WalkingState { IDLE, WALK_LEFT, WALK_RIGHT, SKULL }

var AnimState = WalkingState.IDLE
var speed = 5
var move_interval = 6.0
var change_timer = 3.0

# Custom smaller walkable area (adjust to fit your layout)
var walk_bounds = Rect2(-36, 12, 96, 24)  # x, y, width, height

func _ready():
	randomize()
	_set_state(WalkingState.IDLE)

func _process(delta):
	change_timer += delta
	if change_timer >= move_interval:
		_choose_new_state()
		change_timer = 0.0

	match AnimState:
		WalkingState.WALK_LEFT:
			_move(-1, delta)
		WalkingState.WALK_RIGHT:
			_move(1, delta)
		WalkingState.IDLE, WalkingState.SKULL:
			pass  # No movement during idle or skull

func _move(dir: int, delta: float):
	var sprite_width = 0
	if sprite_frames.has_animation(animation) and sprite_frames.get_frame_count(animation) > 0:
		sprite_width = sprite_frames.get_frame_texture(animation, 0).get_width()

	var new_x = position.x + (dir * speed * delta)

	# Limit hero within walk_bounds (horizontal only)
	if dir > 0 and new_x + sprite_width > walk_bounds.position.x + walk_bounds.size.x:
		_set_state(WalkingState.WALK_LEFT)
	elif dir < 0 and new_x < walk_bounds.position.x:
		_set_state(WalkingState.WALK_RIGHT)
	else:
		position.x = new_x

func _choose_new_state():
	var roll = randf()
	if roll < 0.3:
		_set_state(WalkingState.IDLE)
	elif roll < 0.5:
		_set_state(WalkingState.SKULL)
	else:
		_set_state([WalkingState.WALK_LEFT, WalkingState.WALK_RIGHT].pick_random())

func _set_state(new_state: WalkingState):
	AnimState = new_state
	match AnimState:
		WalkingState.IDLE:
			play("idle")
		WalkingState.SKULL:
			play("skull")
		WalkingState.WALK_LEFT:
			play("walk_left")
		WalkingState.WALK_RIGHT:
			play("walk_right")

extends BaseState

func enter() -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter()

func input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("jump"):
		return State.Jump
	return State.Null

func physics_process(delta: float) -> int:
	if not player.is_on_floor():
		return State.Fall

	var motion := 0
	if Input.is_action_pressed("move_left"):
		motion = -1
		player.set_sprite_dir(player.SPRITE_DIRS.LEFT)
	elif Input.is_action_pressed("move_right"):
		motion = 1
		player.set_sprite_dir(player.SPRITE_DIRS.RIGHT)

	player.velocity.y += player.gravity
	#player.velocity.x = motion * player.walk_speed
	player.velocity.x = lerp(
		float(player.velocity.x),
		float(motion * player.walk_speed if motion else 0.0),
		float(player.acceleration if motion else player.friction)
	)
	player.move_and_slide()
	
	if motion == 0:
		return State.Idle

	return State.Null

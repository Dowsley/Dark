extends BaseState

func enter() -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter()
	player.velocity.y = -player.jump_force

func physics_process(delta: float) -> int:
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
	
	var enter_transition = Utils.is_number_in_range(
		player.velocity.y,
		-player.jump_and_fall_transition_threshold,
		player.jump_and_fall_transition_threshold
	)
	if enter_transition:
		player.animations.play("jump_trans")
	
	if player.velocity.y > 0:
		return State.Fall

	if player.is_on_floor():
		if motion != 0:
			return State.Walk
		else:
			return State.Idle
	return State.Null

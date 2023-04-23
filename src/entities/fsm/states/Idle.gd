extends BaseState

func input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return State.Walk
	elif Input.is_action_just_pressed("jump"):
		return State.Jump
	return State.Null

func physics_process(delta: float) -> int:
	player.velocity.y += player.gravity
	player.velocity.x = lerp(
		player.velocity.x,0.0, player.friction)
	player.move_and_slide()

	if not player.is_on_floor():
		return State.Fall
	return State.Null

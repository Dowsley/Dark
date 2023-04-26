extends BaseMoveAirState

func enter() -> void:
	# We override any anim calls
	# because it only starts AFTER the transition ends
	pass

func physics_process(delta: float) -> BaseState:
	var new_state := super.physics_process(delta)
	if new_state:
		return new_state
	
	var exit_transition = Utils.is_number_in_range(
		player.velocity.y,
		-player.jump_and_fall_transition_threshold,
		player.jump_and_fall_transition_threshold
	)
	if exit_transition:
		player.animations.play("fall")

	return null

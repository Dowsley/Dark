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
		entity.velocity.y,
		-entity.jump_and_fall_transition_threshold,
		entity.jump_and_fall_transition_threshold
	)
	if exit_transition:
		entity.animations.play('fall')

	return null

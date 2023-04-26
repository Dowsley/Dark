extends BaseMoveAirState

@export var fall_node: NodePath

@onready var fall_state: BaseState = get_node(fall_node)

func enter() -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter()
	player.velocity.y = -player.jump_force

func physics_process(delta: float) -> BaseState:
	var new_state := super.physics_process(delta)
	if new_state:
		return new_state
	
	var enter_transition = Utils.is_number_in_range(
		player.velocity.y,
		-player.jump_and_fall_transition_threshold,
		player.jump_and_fall_transition_threshold
	)
	if enter_transition:
		player.animations.play("jump_trans")
	
	if player.velocity.y > 0:
		return fall_state

	return null

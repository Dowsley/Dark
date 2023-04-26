extends PlayerBaseState

@export var run_node: NodePath
@export var walk_node: NodePath
@export var idle_node: NodePath

@onready var run_state: BaseState = get_node(run_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var idle_state: BaseState = get_node(idle_node)

func enter() -> void:
	# We override any anim calls
	# because it only starts AFTER the transition ends
	pass

func physics_process(delta: float) -> BaseState:
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
		float(motion * player.walk_speed),
		float(player.acceleration if motion else player.friction))
	player.move_and_slide()
	
	var exit_transition = Utils.is_number_in_range(
		player.velocity.y,
		-player.jump_and_fall_transition_threshold,
		player.jump_and_fall_transition_threshold
	)
	if exit_transition:
		player.animations.play("fall")

	if player.is_on_floor():
		if motion != 0:
			return walk_state
		else:
			return idle_state
	return null

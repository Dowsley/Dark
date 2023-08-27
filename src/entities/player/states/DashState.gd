extends BaseMoveState

@export var dash_time := 0.25

var current_dash_time := 0.0
var dash_direction := 0

# Upon entering the state, set dash direction to either current input or the direction the player is facing if no input is pressed
func enter() -> void:
	super.enter()
	
	current_dash_time = dash_time
	
	if entity.curr_sprite_dir == entity.SPRITE_DIRS.LEFT:
		dash_direction = -1
	else:
		dash_direction = 1

# Override MoveState input() since we don't want to change states based on player input
func input() -> BaseState:
	return null

# Move in the dash_direction every frame
func get_movement_input() -> int:
	return dash_direction

func physics_process(delta: float) -> BaseState:
	var new_state := super.physics_process(delta)
	# Ignore fall state transition
	if new_state and new_state != fall_state:
		return new_state
	return null

# Track how long we've been dashing so we know when to exit
func process(delta: float) -> BaseState:
	current_dash_time -= delta

	if current_dash_time > 0:
		return null

	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		return walk_state
	return idle_state

func get_move_speed() -> int:
	return entity.dash_speed

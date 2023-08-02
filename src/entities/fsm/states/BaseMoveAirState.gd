class_name BaseMoveAirState
extends EntityBaseState

@export var dash_node: NodePath
@export var walk_node: NodePath
@export var idle_node: NodePath

@onready var dash_state: BaseState = get_node(dash_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var idle_state: BaseState = get_node(idle_node)

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed('dash'):
		return dash_state
	return null

func physics_process(_delta: float) -> BaseState:
	var motion := 0
	if Input.is_action_pressed('move_left'):
		motion = -1
		entity.set_sprite_dir(entity.SPRITE_DIRS.LEFT)
	elif Input.is_action_pressed('move_right'):
		motion = 1
		entity.set_sprite_dir(entity.SPRITE_DIRS.RIGHT)
	
	entity.velocity.y += entity.gravity
	entity.velocity.x = lerp(
		float(entity.velocity.x),
		float(motion * entity.walk_speed),
		float(entity.acceleration if motion else entity.friction)
	)
	entity.move_and_slide()
	
	if entity.is_on_floor():
		if motion != 0:
			return walk_state
		else:
			return idle_state
	
	return null

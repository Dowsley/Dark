class_name BaseMoveState
extends EntityBaseState

@export var jump_node: NodePath
@export var fall_node: NodePath
@export var idle_node: NodePath
@export var walk_node: NodePath
@export var dash_node: NodePath
@export var roll_node: NodePath
@export var attack_node: NodePath

@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var roll_state: BaseState = get_node(roll_node)
@onready var attack_state: BaseState = get_node(attack_node)

func input() -> BaseState:
	if Input.is_action_just_pressed('jump'):
		return jump_state
	elif Input.is_action_just_pressed('dash'):
		return dash_state
	elif Input.is_action_just_pressed('attack'):
		return attack_state

	return null

func physics_process(_delta: float) -> BaseState:
	var motion := get_movement_input()
	if motion < 0:
		entity.set_sprite_dir(entity.SPRITE_DIRS.LEFT)
	elif motion > 0:
		entity.set_sprite_dir(entity.SPRITE_DIRS.RIGHT)
	
	entity.velocity.y += entity.gravity
	entity.velocity.x = lerp(
		float(entity.velocity.x),
		float(motion * get_move_speed()),
		float(entity.acceleration if motion else entity.friction)
	)
	entity.move_and_slide()
	
	if motion == 0:
		return idle_state

	if !entity.is_on_floor():
		return fall_state

	return null

func get_movement_input() -> int:
	if Input.is_action_pressed('move_left'):
		return -1
	elif Input.is_action_pressed('move_right'):
		return 1
	
	return 0

func get_move_speed() -> int:
	return 0

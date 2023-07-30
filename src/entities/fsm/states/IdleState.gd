extends PlayerBaseState

@export var jump_node: NodePath
@export var fall_node: NodePath
@export var walk_node: NodePath
@export var dash_node: NodePath
@export var roll_node: NodePath
@export var attack_node: NodePath

@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var roll_state: BaseState = get_node(roll_node)
@onready var attack_state: BaseState = get_node(attack_node)

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		return walk_state
	elif Input.is_action_just_pressed("jump"):
		return jump_state
	elif Input.is_action_just_pressed("dash"):
		return dash_state
	elif Input.is_action_just_pressed("roll"):
		return roll_state
	elif Input.is_action_just_pressed('attack'):
		return attack_state
	return null

func physics_process(_delta: float) -> BaseState:
	player.velocity.y += player.gravity
	player.velocity.x = lerp(
		player.velocity.x, 0.0, player.friction)
	player.move_and_slide()

	if not player.is_on_floor():
		return fall_state
	return null

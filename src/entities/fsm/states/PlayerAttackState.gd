class_name BaseAttackState
extends EntityBaseState

@export var idle_node: NodePath
@export var walk_node: NodePath
@export var jump_node: NodePath
@export var fall_node: NodePath
@export var dash_node: NodePath
@export var roll_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var roll_state: BaseState = get_node(roll_node)

# @export var combo_window_time := 0.25
# var curr_combo_time := 0.0

@export var attack_chain := [
	'slash1',
	'slash2',
	'slam',
]
var curr_attack_index := 0
var attack_buffered := false

func enter() -> void:
	curr_attack_index = 0
	attack_buffered = false
	entity.attack_animations.play(attack_chain[curr_attack_index])

func input(_event: InputEvent) -> BaseState:
	# if Input.is_action_just_pressed('dash'):
	# 	return dash_state
	# if Input.is_action_just_pressed('roll'):
	# 	return roll_state
	# TODO: cancel attacks similarly to dead cells

	if Input.is_action_just_pressed('attack'):
		attack_buffered = true

	return null

func physics_process(_delta: float) -> BaseState:
	if entity.attack_animations.is_playing():
		return null

	if attack_buffered:
		curr_attack_index += 1
		if not curr_attack_index >= attack_chain.size():
			var motion := get_movement_input()
			if motion < 0:
				entity.set_sprite_dir(entity.SPRITE_DIRS.LEFT)
			elif motion > 0:
				entity.set_sprite_dir(entity.SPRITE_DIRS.RIGHT)
			entity.attack_animations.play(attack_chain[curr_attack_index])
			attack_buffered = false
			return null
	
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		return walk_state
	
	if not entity.is_on_floor():
		if entity.velocity.y < 0:
			return jump_state
		return fall_state
	return idle_state

# TODO find way to consolidate this repeated code.
func get_movement_input() -> int:
	if Input.is_action_pressed('move_left'):
		return -1
	elif Input.is_action_pressed('move_right'):
		return 1
	return 0

class_name Entity
extends CharacterBody2D

const SPRITE_DIST_TO_CENTER := 17
enum SPRITE_DIRS {
	RIGHT,
	LEFT
}

@export var walk_speed := 50
@export var dash_speed := 200
@export var jump_force := 70
@export var gravity := Utils.GRAVITY
@export_range(0.0, 1.0) var friction := 0.1
@export_range(0.0 , 1.0) var acceleration := 0.25
@export_range(0.0, 50) var jump_and_fall_transition_threshold := 20

@onready var states: BaseStateManager = $StateManager
@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_animations: AnimationPlayer = $AttackAnimationPlayer

var curr_sprite_dir := SPRITE_DIRS.RIGHT

func set_sprite_dir(new_dir: SPRITE_DIRS) -> void:
	if new_dir == curr_sprite_dir:
		return
	
	curr_sprite_dir = new_dir
	if new_dir == SPRITE_DIRS.RIGHT:
		position.x += SPRITE_DIST_TO_CENTER
		animations.flip_h = false
	else:
		position.x -= SPRITE_DIST_TO_CENTER
		animations.flip_h = true

func _ready() -> void:
	states.init(self)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)

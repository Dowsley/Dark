extends CharacterBody2D

const SPRITE_DIST_TO_CENTER := 17
enum SPRITE_DIRS {
	RIGHT,
	LEFT
}

@export var walk_speed := 20
@export var run_speed := 50
@export var jump_speed := -80
@export var gravity := 150
@export_range(0.0, 1.0) var friction := 0.1
@export_range(0.0 , 1.0) var acceleration := 0.25
@export_range(0.0, 50) var jump_and_fall_transition_threshold := 5

@onready var anim_player := $AnimatedSprite2D

# Movement and animation members
var h_motion_input := 0.0
var jump_just_pressed_input := false
var jump_just_released_input := false
var is_running := false 
var curr_sprite_dir := SPRITE_DIRS.RIGHT

func set_sprite_dir(new_dir: int):
	curr_sprite_dir = new_dir

	if new_dir == SPRITE_DIRS.RIGHT:
		position.x += SPRITE_DIST_TO_CENTER
		anim_player.flip_h = false
	else:
		position.x -= SPRITE_DIST_TO_CENTER
		anim_player.flip_h = true

func loop_controls():
	h_motion_input = Input.get_axis("walk_left", "walk_right")
	jump_just_pressed_input = Input.is_action_just_pressed("jump")
	jump_just_released_input = Input.is_action_just_released("jump")
	is_running = Input.is_action_pressed("run")

func loop_movement(delta: float):
	velocity.y += gravity * delta
	h_motion_input = Input.get_axis("walk_left", "walk_right")
	is_running = Input.is_action_pressed("run")
	
	if h_motion_input != 0:
		var new_dir := SPRITE_DIRS.LEFT if h_motion_input < 0 else SPRITE_DIRS.RIGHT
		velocity.x = lerp(velocity.x, h_motion_input * (run_speed if is_running else walk_speed), acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed


func loop_animation():
	var dir := SPRITE_DIRS.LEFT if h_motion_input < 0.0 else SPRITE_DIRS.RIGHT
	if dir != curr_sprite_dir:
		set_sprite_dir(dir)

	if is_on_floor():
		if h_motion_input != 0.0:
			anim_player.play("run_fast" if is_running else "walk")
		else:
			anim_player.play("idle")
	else:
		if velocity.y != 0.0:
			if velocity.y > jump_and_fall_transition_threshold:
				anim_player.play("fall")
			elif velocity.y < -jump_and_fall_transition_threshold:
				anim_player.play("jump")
			else:
				anim_player.play("jump_trans")

func _process(delta: float):
	loop_controls()
	loop_movement(delta)
	loop_animation()

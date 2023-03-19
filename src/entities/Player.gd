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

var curr_sprite_dir = SPRITE_DIRS.RIGHT

func _process(delta):
	velocity.y += gravity * delta
	var dir := Input.get_axis("walk_left", "walk_right")
	var is_running := Input.is_action_pressed("run")
	
	if dir != 0:
		anim_player.play("run_fast" if is_running else "walk")
		var new_dir := SPRITE_DIRS.LEFT if dir < 0 else SPRITE_DIRS.RIGHT
		if new_dir != curr_sprite_dir:
			set_sprite_dir(new_dir)
		velocity.x = lerp(velocity.x, dir * (run_speed if is_running else walk_speed), acceleration)
	else:
		anim_player.play("idle")
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# if velocity.y != 0:
	# 	if velocity.y > jump_and_fall_transition_threshold:
	# 		anim_player.play("fall")
	# 	elif velocity.y < -jump_and_fall_transition_threshold:\
	# 		anim_player.play("jump")
	# 	else:
	# 		anim_player.play("jump_trans")
	

func set_sprite_dir(new_dir: int):
	curr_sprite_dir = new_dir
	if new_dir == SPRITE_DIRS.RIGHT:
		position.x += SPRITE_DIST_TO_CENTER
		anim_player.flip_h = false
	elif new_dir == SPRITE_DIRS.LEFT:
		position.x -= SPRITE_DIST_TO_CENTER
		anim_player.flip_h = true

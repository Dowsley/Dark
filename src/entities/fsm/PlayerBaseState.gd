class_name PlayerBaseState
extends BaseState

@export var animation_name: String

var player: Player

func enter() -> void:
	player.animations.play(animation_name)

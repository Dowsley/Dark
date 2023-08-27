class_name EntityBaseState
extends BaseState

@export var animation_name: String

var entity: Entity

func input() -> BaseState:
	return null

func enter() -> void:
	entity.animations.play(animation_name)

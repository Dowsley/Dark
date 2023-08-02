class_name EntityBaseState
extends BaseState

@export var animation_name: String

var entity: Entity

func enter() -> void:
	entity.animations.play(animation_name)

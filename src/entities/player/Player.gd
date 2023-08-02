class_name Player
extends Entity

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

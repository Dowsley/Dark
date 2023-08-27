class_name Player
extends Entity

func _unhandled_input(_event: InputEvent) -> void:
	states.input()

class_name EntityStateManager
extends BaseStateManager

var entity: Entity

func init(node: Node) -> void:
	for child in get_children():
		child.entity = node
	super.init(node)

func input() -> void:
	var new_state = current_state.input()
	if new_state:
		change_state(new_state)

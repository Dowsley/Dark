extends BaseStateManager

var player: Player

func init(node: Node) -> void:
	for child in get_children():
		child.player = node
	super.init(node)

func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)

func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)

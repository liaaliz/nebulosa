extends Node
@export var mouse_data : MousePositionData
func _physics_process(delta: float) -> void:
	mouse_data.mouse_pos = get_viewport().get_mouse_position()

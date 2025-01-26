extends Node
var _can_restart := false

func _unhandled_key_input(event: InputEvent) -> void:
	if !_can_restart : return
	if !Input.is_action_just_pressed("restart"): return
	
	get_tree().reload_current_scene()

func flip_can_restart():
	_can_restart = true

extends Node
@export var death_clock_label : RichTextLabel

var _can_restart := false

func _unhandled_key_input(event: InputEvent) -> void:
	if !_can_restart : return
	if !Input.is_action_just_pressed("restart"): return
	
	get_tree().reload_current_scene()

func death_clock(_time_left : float, _color : Color):
	if _can_restart: return
	var danger : String
	
	if _time_left >= 3:
		danger = ""
	elif _time_left > 2:
		danger = "!"
	elif _time_left > 1:
		danger = "!!"
	else:
		danger = "!!!"
	
	death_clock_label.text = "[b][font_size=25][right] " + danger + str(_time_left).pad_decimals(2) + danger
	death_clock_label.modulate = _color
	
func flip_can_restart():
	_can_restart = true
	death_clock_label.text = "[b][font_size=25][right] press r to restart"

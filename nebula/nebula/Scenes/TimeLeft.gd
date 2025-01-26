extends Node
@export var time_left_data : TimeLeftData

func _process(delta: float) -> void:
	print(time_left_data.time_left)

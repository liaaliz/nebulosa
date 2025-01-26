extends ColorRect
@export var player : Player

func _process(delta: float) -> void:
	if player != null:
		modulate = player.modulate

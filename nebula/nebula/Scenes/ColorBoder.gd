extends ColorRect
@export var player : Player

func _process(delta: float) -> void:
	modulate = player.modulate

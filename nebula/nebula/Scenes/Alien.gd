extends Node2D
@export var player : Player 

func _ready() -> void:
	randomize()
	await get_tree().create_timer(randi() % 10)

func _process(delta: float) -> void:
	position = position.slerp(player.position, delta * 1.2)

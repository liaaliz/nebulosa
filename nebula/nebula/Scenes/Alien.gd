extends Node2D
@export var player : Player 

func _ready() -> void:
	randomize()
	await get_tree().create_timer(randi() % 10)

func _process(delta: float) -> void:
	if player == null : return 
	position = position.slerp(player.position, delta * 1.2)

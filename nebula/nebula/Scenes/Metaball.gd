class_name Metaball
extends Sprite2D
var size : Texture = preload("res://Art/BallGradient.png") as CompressedTexture2D
var move_speed : int = 5

func _init(_move_speed := move_speed, _size := size) -> void:
	move_speed = _move_speed
	size = _size
	self.texture = size

func _physics_process(delta: float) -> void:
	movement_strategy()
	
func movement_strategy(movement := default_movement):
	movement.call()

func default_movement(delta := get_process_delta_time()):
	position.x -= move_speed * delta 

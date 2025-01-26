class_name Metaball
extends Sprite2D
var size : Texture2D = preload("res://Art/ZerothMetaball.png") as CompressedTexture2D
var move_speed : int = 5
var movement_strategy : Callable
var default_movement := func(delta := get_process_delta_time()): position.x -= move_speed * delta 

func _init(_move_speed := move_speed, _size := size, _movement_strategy := initial_movement_strategy) -> void:
	move_speed = _move_speed
	size = _size
	movement_strategy = _movement_strategy
	self.texture = size

func _physics_process(delta: float) -> void:
	movement_strategy.call()
	if position.x < 0 - size.get_width():
		position.x = 640 + 100

func initial_movement_strategy(delta := get_process_delta_time()):
	if scale <= Vector2.ZERO : return
	scale.x -= (move_speed * delta)/100
	scale.y -= (move_speed * delta)/100

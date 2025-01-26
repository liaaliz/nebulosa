extends Sprite2D
var MOVE_SPEED : int = 5

func _ready() -> void:
	randomize()
	MOVE_SPEED = randi() % 40 + 5
	position.y = randi() % 360

func _physics_process(delta: float) -> void:
	position.x -= MOVE_SPEED * delta

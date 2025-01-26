extends Node2D
@export var player_data : PlayerPositionData

var stars_array : Array = [
	preload("res://Art/CyanStar.png") as CompressedTexture2D,
	preload("res://Art/MagentaStar.png") as CompressedTexture2D,
	preload("res://Art/YellowStar.png") as CompressedTexture2D
	]
@onready var star_layers = get_children()

func _ready() -> void:
	for i in range(0, 30):
		var new_star = Sprite2D.new()
		randomize()
		new_star.position = Vector2(randi() % 640, randi() % 360)
		star_layers[randi()% get_child_count()].add_child(new_star)
		new_star.texture = stars_array[randi() % stars_array.size()]

func _process(delta: float) -> void:
	var factor = 5
	var smooth = 0.1
	
	for i in range(0, star_layers.size()):
		star_layers[i].position.x =  -factor * (player_data.player_position.x - 180) * delta
		star_layers[i].position.y = -factor * (player_data.player_position.y + 320) * delta
		factor -= 2
		smooth -= 0.05 

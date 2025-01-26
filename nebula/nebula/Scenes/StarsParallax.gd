extends Node2D
var stars_array : Array = [
	preload("res://Art/CyanStar.png") as CompressedTexture2D,
	preload("res://Art/MagentaStar.png") as CompressedTexture2D,
	preload("res://Art/YellowStar.png") as CompressedTexture2D
	]

func _ready() -> void:
	var children = get_children()
	for i in range(0, 60):
		var new_star = Sprite2D.new()
		randomize()
		new_star.position = Vector2(randi() % 640, randi() % 360)
		children[randi()% get_child_count()].add_child(new_star)
		new_star.texture = stars_array[randi() % stars_array.size()] 

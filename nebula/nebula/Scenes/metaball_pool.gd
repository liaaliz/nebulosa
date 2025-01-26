extends Node2D
var texture_array : Array = [
	preload("res://Art/MediumMetaball.png") as CompressedTexture2D,
	preload("res://Art/GreatestMetaball.png") as CompressedTexture2D
	]

func _ready() -> void:
	add_metaball(get_child(0))

func add_metaball(last_metaball : Metaball):
	if get_child_count() >= 75:
		return
	randomize()
	await get_tree().create_timer(2 + randi() % 2 + 1).timeout
	
	var cur_child_position := get_child_count() -1
	for i in range(0, 4):
		var new_metaball = Metaball.new(40 + randi() % 60, texture_array[randi() % texture_array.size()])
		new_metaball.movement_strategy = new_metaball.default_movement
		new_metaball.position = Vector2(640 + (200 - randi() % 20), randi() % 360)
		
		var scale_factor = randf() + 0.5
		new_metaball.scale *= scale_factor
		
		last_metaball.add_sibling(new_metaball)
		last_metaball = new_metaball
		cur_child_position += 1
		
	
	add_metaball(get_child(cur_child_position))

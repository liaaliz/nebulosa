extends Node2D

func _ready() -> void:
	add_metaball(get_child(0))

func add_metaball(last_metaball : Metaball):
	if get_child_count() >= 50:
		return
		
	print("adding metaball")
	await get_tree().create_timer(5).timeout
	
	var new_metaball = Metaball.new()
	new_metaball.position = Vector2(640 + 20, 180)
	last_metaball.add_sibling(new_metaball)
	
	add_metaball(new_metaball)

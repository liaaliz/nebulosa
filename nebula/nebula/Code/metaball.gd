class_name Metaball
extends Sprite2D

var type : MetaballPool.MetaballType

func _init():
	randomize()

func _ready() -> void:
	call_deferred("reset_metaball", self)

func _physics_process(delta: float) -> void:
	position.x -= type.move_speed * delta

func reset_metaball(metaball: Metaball):
	var pool = get_parent()
	if pool.types.is_empty():
		return
		
	var which_type = randi() % pool.types.size() 
	type = pool.types[which_type]
	position = metaball.type.handle_init_position()

extends Node
@onready var bitmap_player := BitMap.new() 
@onready var bitmap_metaballs := BitMap.new()
@onready var out_of_bounds_timer := Timer.new()

@export var viewport_player : Viewport
@export var viewport_metaballs : Viewport
@export var player : Player 
var out_of_bounds : bool = false

func _ready() -> void:
	out_of_bounds_timer.autostart = false
	out_of_bounds_timer.one_shot = true
	out_of_bounds_timer.wait_time = 3.0
	
	out_of_bounds_timer.timeout.connect(player.queue_free)
	out_of_bounds_timer.timeout.connect(get_child(0).flip_can_restart)
	
	add_child(out_of_bounds_timer)

func _process(delta: float) -> void:
	if player != null:
		process_out_of_bounds_timer()
		
	bitmap_player.create_from_image_alpha(viewport_player.get_texture().get_image())
	bitmap_metaballs.create_from_image_alpha(viewport_metaballs.get_texture().get_image())
	
	if guard_full_bitmap(): return
	
	var loop_size = bitmap_player.get_size().x -1;               
	var player_bits : Array[Vector2] = [] 
	
	for i in range(0, loop_size):
		for j in range(0, loop_size):
			if (!bitmap_player.get_bit(i, j)) : continue
			player_bits.append(Vector2(i,j))
	
	var collided_pixels : Array[bool] = []
	
	for i in range(0, player_bits.size()):
		if (!bitmap_metaballs.get_bitv(player_bits[i])) : break
		collided_pixels.append(true)
	
	if collided_pixels.size() == player_bits.size():
		out_of_bounds = true if out_of_bounds != true else out_of_bounds
		return
	
	out_of_bounds = false if out_of_bounds != false else out_of_bounds

func process_out_of_bounds_timer():
	if !out_of_bounds:
		out_of_bounds_timer.stop()
		
	if out_of_bounds and out_of_bounds_timer.is_stopped():
		out_of_bounds_timer.start()
		
	if !out_of_bounds_timer.is_stopped():
		print(out_of_bounds_timer.time_left)

func guard_full_bitmap() -> bool:
	if bitmap_metaballs.get_true_bit_count() == 0:
		out_of_bounds = false if out_of_bounds != false else out_of_bounds
		return true
		
	if bitmap_metaballs.get_true_bit_count() == 256:
		out_of_bounds = true if out_of_bounds != true else out_of_bounds
		return true
	return false

extends Node
@onready var bitmap_player := BitMap.new() 
@onready var bitmap_metaballs := BitMap.new()
@onready var out_of_bounds_timer := Timer.new()
@onready var score_timer := Timer.new()

@export var viewport_player : Viewport
@export var viewport_metaballs : Viewport
@export var player : Player 
@export var restart_prompt : Node
@export var score_label : RichTextLabel
@export var final_score_label : RichTextLabel

var score : int = 0
var score_mult : int = 1
var score_magnitude : int = 0
var score_is_running := false
var streak : int

var out_of_bounds : bool = false

func _ready() -> void:
	out_of_bounds_timer.autostart = false
	out_of_bounds_timer.one_shot = true
	out_of_bounds_timer.wait_time = 3.0
	out_of_bounds_timer.timeout.connect(player.queue_free)
	out_of_bounds_timer.timeout.connect(restart_prompt.flip_can_restart)
	out_of_bounds_timer.timeout.connect(final_score) 
	add_child(out_of_bounds_timer)
	
	score_timer.autostart = false
	score_timer.one_shot = true
	score_timer.wait_time = 0.5
	score_timer.timeout.connect(update_score)
	add_child(score_timer)

func _process(delta: float) -> void:
	if player != null:
		process_out_of_bounds_timer()
		process_player_recollor()
		
	bitmap_player.create_from_image_alpha(viewport_player.get_texture().get_image())
	bitmap_metaballs.create_from_image_alpha(viewport_metaballs.get_texture().get_image())
	
	if guard_full_bitmap(): return
	
	var loop_size = bitmap_player.get_size().x;               
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
		score_timer.stop()
		restart_prompt.death_clock(3.0, player.modulate)
		streak = 1
		return
	
	restart_prompt.death_clock(out_of_bounds_timer.time_left, player.modulate)
	
	if out_of_bounds and out_of_bounds_timer.is_stopped():
		score_timer.start()
		out_of_bounds_timer.start()

func guard_full_bitmap() -> bool:
	if bitmap_metaballs.get_true_bit_count() == 0:
		out_of_bounds = false if out_of_bounds != false else out_of_bounds
		return true
		
	if bitmap_metaballs.get_true_bit_count() == 256:
		out_of_bounds = true if out_of_bounds != true else out_of_bounds
		return true
	return false

func process_player_recollor():
	if !out_of_bounds:
		player.modulate = Color.CYAN
		return

	if out_of_bounds_timer.time_left > out_of_bounds_timer.wait_time * 0.5:
		player.modulate = Color.YELLOW
		return
	
	player.modulate = Color.MAGENTA

func update_score():
	score_label.text = "[b][left][font_size=14]" + str(score) + " + " + str(score_mult) + " x 10^" + str(score_magnitude)
	score += 5 * streak
	
	if score < 10:
		return
	
	if score_magnitude == 0:
		score_magnitude += 1
	
	var magnitude = int(pow(10, score_magnitude))
	
	if score % magnitude == 0 or score > magnitude:
		score_mult += 1
		score = score % magnitude
	
	if score_mult % magnitude == 0:
		score_magnitude += 1
		score_mult = 1

func final_score():
	final_score_label.text = "[b][font_size=36][center]" + str(score) + " + " + str(score_mult) + " x 10^" + str(score_magnitude)
	final_score_label.visible = true
	score_label.visible = false
	

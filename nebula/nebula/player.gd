extends CharacterBody2D
const BOOST_VAL := 2000
var orientation
@onready var reload_timer = Timer.new()

func _ready() -> void:
	reload_timer.autostart = false
	reload_timer.wait_time = 1.0

func _unhandled_key_input(event: InputEvent) -> void:
	boost()
		
func _physics_process(delta: float) -> void:
	orientation = Vector2.RIGHT.rotated(rotation)
	var mouse_pos = get_global_mouse_position()
	look_at(Vector2(mouse_pos.x, mouse_pos.y))
	move_and_slide()
	
	#edge case:
	# when the player is to close to the mouse, it starts to spin.
	# give a minimum threshold of when the player is at some distance
	# from the mouse

func boost():
	if Input.is_action_pressed("boost"):
		velocity += orientation * BOOST_VAL
		velocity = velocity.limit_length(200.0)
		
func shoot():
	pass
	#if Input.is_action_just_pressed("shoot"):

extends CharacterBody2D
const BOOST_VAL := 60
var orientation

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(Vector2(mouse_pos.x, mouse_pos.y))
	orientation = Vector2.RIGHT.rotated(rotation)
	
	boost()
	move_and_slide()
	
	#edge case:
	# when the player is to close to the mouse, it starts to spin.
	# give a minimum threshold of when the player is at some distance
	# from the mouse

func boost():
	if Input.is_action_pressed("boost"):
		velocity = lerp(velocity, orientation * BOOST_VAL, 0.3)

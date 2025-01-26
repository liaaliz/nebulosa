class_name Player
extends CharacterBody2D

@export var mouse_data : MousePositionData
const _BOOST_VAL := 60
var _orientation

func _physics_process(delta: float) -> void:
	look_at(Vector2(mouse_data.mouse_pos.x, mouse_data.mouse_pos.y))
	_orientation = Vector2.RIGHT.rotated(rotation)
	
	boost()
	move_and_slide()
	
	#edge case:
	# when the player is to close to the mouse, it starts to spin.
	# give a minimum threshold of when the player is at some distance
	# from the mouse

func boost():
	if Input.is_action_pressed("boost"):
		velocity = lerp(velocity, _orientation * _BOOST_VAL, 0.3)

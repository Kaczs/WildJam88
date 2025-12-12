extends MovementState
var speed

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play idle animation
	speed = get_parent().move_speed
	#print("I am currently Running")

func phys_update(_delta: float):
	player_body.velocity.y += gravity * _delta
	var horizontal_input = Input.get_axis("Left", "Right")
	player_body.velocity.x = horizontal_input * speed * 0
	if is_equal_approx(horizontal_input, 0.0):
		finished.emit("StateIdle")
	player_body.move_and_slide()

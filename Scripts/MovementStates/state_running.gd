extends MovementState
var speed

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play idle animation
	speed = parent.move_speed

func phys_update(_delta: float):
	# Gravity
	player_body.velocity.y += gravity * _delta
	# Start running based on player input
	var horizontal_input = Input.get_axis("Left", "Right")
	player_body.velocity.x = horizontal_input * speed
	# Stop running go idle
	if is_equal_approx(horizontal_input, 0.0):
		finished.emit("StateIdle")
	# Trying to jump?
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	player_body.move_and_slide()

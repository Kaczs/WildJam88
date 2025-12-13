extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play idle animation
	parent.animated_sprite.play("standingattack")

func phys_update(_delta: float):
	# Gravity
	player_body.velocity.y += gravity * _delta
	# Start running based on player input
	var horizontal_input = Input.get_axis("Left", "Right")
	# Stopped crouching when trying to run? Stand and run
	if abs(horizontal_input) > 0:
		finished.emit("StateRunning")
	# Trying to jump?
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	player_body.move_and_slide()
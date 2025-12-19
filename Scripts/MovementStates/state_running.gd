extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play idle animation
	animation_player.play("running")

func phys_update(_delta: float):
	# Gravity
	player_body.velocity.y += gravity * _delta
	# Start running based on player input
	var horizontal_input = Input.get_axis("Left", "Right")
	# Flip sprite by direction
	if horizontal_input < 0:
		sprite.flip_h = true
	elif horizontal_input > 0:
		sprite.flip_h = false
	player_body.velocity.x = horizontal_input * speed
	# Stop running go idle
	if is_equal_approx(horizontal_input, 0.0):
		finished.emit("StateIdle")
	# Trying to jump?
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	elif Input.is_action_just_pressed("Attack"):
		finished.emit("StateComboDecide")
	elif Input.is_action_just_pressed("dash"):
		finished.emit("StateMicroDash")
	elif Input.is_action_just_pressed("special1") and impulsiveness_component.current_impulsiveness >= 25:
		finished.emit("StateRadiantDash")
	elif Input.is_action_pressed("Down"):
		finished.emit("StateCrouch")
	elif player_body.velocity.y >= 0 and not player_body.is_on_floor():
		finished.emit("StateFalling")
	player_body.move_and_slide()

extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play jump animation
	animation_player.play("jumping")
	player_body.velocity.y = -parent.jump_power

func phys_update(_delta: float):
	var horizontal_input = Input.get_axis("Left", "Right")
	player_body.velocity.x = (horizontal_input * speed)
	player_body.velocity.y += gravity * _delta
	# Flip sprite by direction
	if horizontal_input < 0:
		sprite.flip_h = true
	elif horizontal_input > 0:
		sprite.flip_h = false
	if player_body.is_on_floor() and abs(horizontal_input) > 0:
		finished.emit("StateRunning")
	elif player_body.is_on_floor():
		finished.emit("StateIdle")
	elif player_body.velocity.y >= 0:
		finished.emit("StateFalling")
	player_body.move_and_slide()

func exit() -> void:
	pass

extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play falling animation
	pass

func phys_update(_delta: float):
	player_body.velocity.y += gravity * _delta
	if player_body.is_on_floor() and abs(Input.get_axis("Left", "Right")) > 0:
		finished.emit("StateRunning")
	elif player_body.is_on_floor():
		finished.emit("StateIdle")
	player_body.move_and_slide()

func exit() -> void:
	pass
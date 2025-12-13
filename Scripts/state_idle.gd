extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play idle animation
	#print("I am currently Idle")
	pass

func phys_update(_delta: float):
	player_body.velocity.y += gravity * _delta
	player_body.move_and_slide()
	if not player_body.is_on_floor():
		pass # We falling
	elif Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		finished.emit("StateRunning")

func exit() -> void:
	pass

extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play falling animation
	animation_player.play("glaivelanding")

func phys_update(_delta: float):
	# Scale gravity as you go
	player_body.velocity.y += (gravity * _delta)
	var horizontal_input = Input.get_axis("Left", "Right")
	player_body.velocity.x = horizontal_input * speed
	if Input.is_action_just_pressed("special1"):
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

func exit() -> void:
	pass

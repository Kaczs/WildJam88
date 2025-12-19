extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play falling animation
	player_body.velocity.x = 0
	animation_player.play("glaivelanding")

func phys_update(_delta: float):
	# Scale gravity as you go
	player_body.velocity.y += (gravity * _delta)
	if Input.is_action_just_pressed("special1") and parent.radiantd_timer.is_stopped()\
	and impulsiveness_component.current_impulsiveness >=25:
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

func exit() -> void:
	pass

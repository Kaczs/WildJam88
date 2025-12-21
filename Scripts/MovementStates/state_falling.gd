extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play falling animation
	animation_player.play("falling")

func phys_update(_delta: float):
	# Multiple gravity when falling by 2, feels better
	player_body.velocity.y += (gravity * _delta) * 2
	var horizontal_input = Input.get_axis("Left", "Right")
	player_body.velocity.x = horizontal_input * (speed*0.7)
	# Flip sprite by direction
	if horizontal_input < 0:
		sprite.flip_h = true
	elif horizontal_input > 0:
		sprite.flip_h = false
	if player_body.is_on_floor() and abs(Input.get_axis("Left", "Right")) > 0:
		finished.emit("StateRunning")
	elif Input.is_action_just_pressed("dash")  and parent.dash_timer.is_stopped():
		finished.emit("StateMicroDash")
	elif Input.is_action_just_pressed("Parry"):
		finished.emit("StateParry")
	elif player_body.is_on_floor():
		finished.emit("StateIdle")
	elif Input.is_action_just_pressed("Attack"):
			finished.emit("StateGlaiveFall")
	elif Input.is_action_just_pressed("special1") and impulsiveness_component.current_impulsiveness >= 33\
	 and parent.radiantd_timer.is_stopped():
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

func exit() -> void:
	pass

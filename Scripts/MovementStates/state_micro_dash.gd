extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	if sprite.flip_h == false:
		player_body.position.x += 400
	else:
		parent.flip_character()
		player_body.position.x -= 400
	animation_player.play("microdash")

func phys_update(_delta: float):
	player_body.velocity.y += gravity * _delta
	
	if not player_body.is_on_floor():
		finished.emit("StateFalling")
	# if were cancel
	elif Input.is_action_just_pressed("Attack"):
		finished.emit("StateStandingAttack")
	elif Input.is_action_just_pressed("Parry"):
		finished.emit("StateParry")
	elif Input.is_action_pressed("Down"):
		finished.emit("StateCrouch")
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		finished.emit("StateRunning")
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	elif Input.is_action_just_pressed("special1") and impulsiveness_component.current_impulsiveness >= 25:
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

func exit() -> void:
	pass

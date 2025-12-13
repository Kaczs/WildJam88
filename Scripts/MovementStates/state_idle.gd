extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	parent.animated_sprite.play("idle")

func phys_update(_delta: float):
	player_body.velocity.y += gravity * _delta
	if not player_body.is_on_floor():
		finished.emit("StateFalling")
	elif Input.is_action_just_pressed("Attack"):
		finished.emit("StateStandingAttack")
	elif Input.is_action_pressed("Down"):
		finished.emit("StateCrouch")
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		finished.emit("StateRunning")
	elif Input.is_action_just_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")	
	player_body.move_and_slide()

func exit() -> void:
	pass

extends MovementState
var target:Vector2
var dash_particles:CPUParticles2D

func enter(_previous_state_path: String, _data := {}):
	if dash_particles == null:
		dash_particles = find_child("DashParticles")
	parent.dash_timer.start()
	var direction = player_body.velocity.normalized()
	if sprite.flip_h == true:
		parent.flip_character()
	target = player_body.global_position + (direction * 400)
	var safe_pos = TeleportFinder.find_valid_position(player_body, target)
	dash_particles.position = player_body.position
	dash_particles.emitting = true
	player_body.position = safe_pos

func phys_update(_delta: float):
	player_body.velocity.y += gravity * _delta
	
	if not player_body.is_on_floor():
		finished.emit("StateFalling")
	# if were cancel
	elif Input.is_action_pressed("Attack"):
		finished.emit("StateComboDecide")
	elif Input.is_action_pressed("Parry"):
		finished.emit("StateParry")
	elif Input.is_action_pressed("Down"):
		finished.emit("StateCrouch")
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		finished.emit("StateRunning")
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	elif Input.is_action_just_pressed("special1") and impulsiveness_component.current_impulsiveness >= 33:
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

func exit() -> void:
	pass

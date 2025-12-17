extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# Flip hitbox depending on facing
	if sprite.flip_h == true:
		parent.flip_character()
	animation_player.play("standingattack3")

func phys_update(_delta: float):
	# Gravity
	player_body.velocity.y += gravity * _delta
	# Slide the player forward as they attack
	if parent.slide_forward == true:
		if sprite.flip_h == true:
			player_body.velocity.x = -600.0
		else:
			player_body.velocity.x = 600.0
	else:
		player_body.velocity.x = 0
# Stuff we need to Cancel into
	if parent.cannot_cancel == false:	
		var horizontal_input = Input.get_axis("Left", "Right")
		# Start running based on player input
		if abs(horizontal_input) > 0:
			finished.emit("StateRunning")
		# Trying to jump?
		elif Input.is_action_pressed("Up") and player_body.is_on_floor():
			finished.emit("StateJumping")
# Can freely cancel anytime
	elif Input.is_action_just_pressed("special1"):
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

func exit() -> void:
	player_body.velocity.x = 0
extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play idle animation
	animation_player.play("standingattack")

func phys_update(_delta: float):
	# Gravity
	player_body.velocity.y += gravity * _delta
	# Start running based on player input
	var horizontal_input = Input.get_axis("Left", "Right")
	# Stopped crouching when trying to run? Stand and run
	if abs(horizontal_input) > 0:
		finished.emit("StateRunning")
	elif Input.is_action_just_pressed("Attack"):
		finished.emit("StateStandingAttack2")
	# Trying to jump?
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	# Optionally immediately animation: X X X 
	# if hit
	# 0.16s after animation then unlock player > nother attack > jump > move > parry
	# kill 0.16s delay if hit a guy
	player_body.move_and_slide()
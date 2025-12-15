extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# Flip hitbox depending on facing
	if sprite.flip_h == true:
		parent.flip_character()
	animation_player.play("standingattack")

func phys_update(_delta: float):
	# Slide the player forward as they attack
	if parent.slide_forward == true:
		player_body.velocity.x = 10.0
	# Gravity
	player_body.velocity.y += gravity * _delta
	# Start running based on player input
	var horizontal_input = Input.get_axis("Left", "Right")
	if abs(horizontal_input) > 0:
		finished.emit("StateRunning")
	# Next attack in the chain
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

func exit() -> void:
	player_body.velocity.x = 0

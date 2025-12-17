extends MovementState
@export var is_doing_air := false

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play idle animation
	if sprite.flip_h == false:
		player_body.position.x += 700
	else:
		parent.flip_character()
		player_body.position.x -= 700
	# Wait
	if not player_body.is_on_floor():
		animation_player.play("radiantdashair")
		player_body.velocity.x = 0
		is_doing_air = true
	else:
		animation_player.play("radiantdash")

func phys_update(_delta: float):
	# Gravity, if doing the air variant slow gravity a lot
	if is_doing_air == false:
		player_body.velocity.y += gravity * _delta
	else:
		player_body.velocity.y += (gravity * 0.3 ) * _delta
	# Start running based on player input
	var horizontal_input = Input.get_axis("Left", "Right")
	# Stopped crouching when trying to run? Stand and run
	if abs(horizontal_input) > 0:
		finished.emit("StateRunning")
	# Trying to jump?
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	player_body.move_and_slide()

func exit() -> void:
	is_doing_air = false

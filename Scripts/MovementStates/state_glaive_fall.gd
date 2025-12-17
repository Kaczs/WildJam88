extends MovementState
var falling_factor := 2.0

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play falling animation
	animation_player.play("glaivefall")

func phys_update(_delta: float):
	falling_factor += (_delta*2)
	# Scale gravity as you go
	player_body.velocity.y += (gravity * _delta) * falling_factor
	print(falling_factor)
	var horizontal_input = Input.get_axis("Left", "Right")
	player_body.velocity.x = horizontal_input * speed
	# Flip sprite by direction
	if horizontal_input < 0:
		sprite.flip_h = true
	elif horizontal_input > 0:
		sprite.flip_h = false
	if player_body.is_on_floor():
		finished.emit("StateGlaiveLanding")
	elif Input.is_action_just_pressed("special1"):
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

func exit() -> void:
	falling_factor = 2.0

extends MovementState
var speed

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	# play falling animation
	speed = parent.move_speed
	parent.animated_sprite.play("falling")
	pass

func phys_update(_delta: float):
	# Multiple gravity when falling by 2, feels better
	player_body.velocity.y += (gravity * _delta) * 2
	var horizontal_input = Input.get_axis("Left", "Right")
	player_body.velocity.x = horizontal_input * speed
	# Flip sprite by direction
	if horizontal_input < 0:
		parent.animated_sprite.flip_h = true
	elif horizontal_input > 0:
		parent.animated_sprite.flip_h = false
	if player_body.is_on_floor() and abs(Input.get_axis("Left", "Right")) > 0:
		finished.emit("StateRunning")
	elif player_body.is_on_floor():
		finished.emit("StateIdle")
	player_body.move_and_slide()

func exit() -> void:
	pass
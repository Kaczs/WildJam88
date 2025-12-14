extends MovementState
var player_collider:CollisionShape2D

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	animation_player.play("crouching")
	player_collider = owner.find_child("CollisionShape2D")
	# Change collider size (do this in animation player later)
	player_collider.scale = Vector2(4,2)
	player_collider.position.y = 50.0

func phys_update(_delta: float):
	# Gravity
	player_body.velocity.y += gravity * _delta
	# Start running based on player input
	var horizontal_input = Input.get_axis("Left", "Right")
	# Flip sprite by direction
	if horizontal_input < 0:
		sprite.flip_h = true
	elif horizontal_input > 0:
		sprite.flip_h = false
	player_body.velocity.x = horizontal_input * speed
	# Stopped crouching when trying to run? Stand and run
	if not Input.is_action_pressed("Down") and abs(horizontal_input) > 0:
		finished.emit("StateRunning")
	# Stopped crouching while idle
	elif not Input.is_action_pressed("Down"):
		finished.emit("StateIdle")
	# Trying to jump?
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	player_body.move_and_slide()

func exit() -> void:
	# Change collider size back
	player_collider.scale = Vector2(4,4)
	player_collider.position.y = 0

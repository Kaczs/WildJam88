extends MovementState
@export var is_doing_air := false
var target:Vector2

func enter(_previous_state_path: String, _data := {}):
	parent.radiantd_timer.start()
	# cancel out any momentum
	# play idle animation
	if sprite.flip_h == false:
		target = Vector2(player_body.position.x+800, player_body.position.y)
	else:
		parent.flip_character()
		target = Vector2(player_body.position.x-800, player_body.position.y)
	var safe_pos = TeleportFinder.find_valid_position(player_body, target)
	player_body.position = safe_pos
	# Wait
	if not player_body.is_on_floor():
		animation_player.play("radiantdashair")
		player_body.velocity.x = 0
		# Need to cancel any velocity from jumps first
		player_body.velocity.y = 0
		is_doing_air = true
	else:
		animation_player.play("radiantdash")
	player_body.velocity.x = 0

func phys_update(_delta: float):
	# Gravity, if doing the air variant slow gravity a lot
	if is_doing_air == false:
		player_body.velocity.y += gravity * _delta
	else:
		player_body.velocity.y += (gravity * 0.2 ) * _delta
	if Input.is_action_just_pressed("Parry"):
		finished.emit("StateParry")
	player_body.move_and_slide()

func exit() -> void:
	is_doing_air = false

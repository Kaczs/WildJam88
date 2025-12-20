extends MovementState
var target:Vector2
@export var spear_node = preload("res://Scenes/spear.tscn")

func enter(_previous_state_path: String, _data := {}):
	parent.spear_timer.start()
	animation_player.play("throwspear")

func phys_update(_delta: float):
	player_body.velocity.y += gravity * _delta
	
	if not player_body.is_on_floor():
		finished.emit("StateFalling")
	# if were cancel
	elif Input.is_action_just_pressed("Attack"):
		finished.emit("StateStandingAttack")
	elif Input.is_action_just_pressed("Parry"):
		finished.emit("StateParry")
	elif Input.is_action_pressed("Down"):
		finished.emit("StateCrouch")
	elif Input.is_action_pressed("Up") and player_body.is_on_floor():
		finished.emit("StateJumping")
	elif Input.is_action_just_pressed("special1") and impulsiveness_component.current_impulsiveness >= 25:
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

func spawn_spear():
	var spawn_point = Vector2(0,0)
	if sprite.flip_h == true:
		spawn_point = Vector2(player_body.global_position.x-300, player_body.global_position.y)
	else:
		spawn_point = Vector2(player_body.global_position.x+300, player_body.global_position.y)
	var spear = spear_node.instantiate()
	get_tree().get_root().add_child(spear)
	spear.global_position = spawn_point
	if sprite.flip_h == true:
		spear.flipped = true

func exit() -> void:
	pass

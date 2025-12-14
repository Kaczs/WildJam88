extends EnemyState

var animation_player:AnimationPlayer

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]
	animation_player = get_parent().animation_player
	attack()

func phys_update(_delta: float):
	if not animation_player.is_playing():
		#if player not in attack range then change state to EnemyChase else attack
		if player.global_position.x - get_parent().global_position.x > get_parent().attack_distance:
			finished.emit("EnemyChase", {"player": player})
			return
		attack()

func attack():
	#gets direction of player then plays the corresponding animation
	if player.global_position.x - get_parent().global_position.x > 0:
		animation_player.play("AttackRight")
	else:
		animation_player.play("AttackLeft")

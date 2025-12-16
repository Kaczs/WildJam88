extends EnemyState

var attack

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]
	pick_attack()

func phys_update(_delta: float):
	if not animation_player.is_playing():
		#if player not in attack range then change state to EnemyChase else attack
		if abs(player.global_position.x - get_parent().global_position.x) > get_parent().attack_distance:
			finished.emit("EnemyChase", {"player": player})
			return
		pick_attack()

func pick_attack():
	var distance_to_player = abs(player.global_position.x - get_parent().global_position.x)
	var children = get_children().pick_random()
	if attack:
		children = attack
	if children.min_range > distance_to_player:
		#finished.emit("EnemyRun")
		pass
	elif distance_to_player > children.max_range:
		finished.emit("EnemyChase", {"temp attack range": children.max_range, "player": player})
		attack = children
	else:
		children.attack(player, animation_player, enemy_body)
		attack = null
		return
	finished.emit("EnemyChase", {"player": player})

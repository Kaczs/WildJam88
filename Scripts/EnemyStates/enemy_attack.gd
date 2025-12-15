extends EnemyState

var bodies_hit:Array

func _ready() -> void:
	await get_parent().get_parent().ready
	get_parent().hit_box.connect("body_entered", _hit_box_body_entered)


func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]
	attack()

func phys_update(_delta: float):
	if not animation_player.is_playing():
		#if player not in attack range then change state to EnemyChase else attack
		if abs(player.global_position.x - get_parent().global_position.x) > get_parent().attack_distance:
			finished.emit("EnemyChase", {"player": player})
			return
		attack()

func attack():
	#gets direction of player then plays the corresponding animation
	bodies_hit.clear()
	if player.global_position.x - get_parent().global_position.x > 0:
		animation_player.play("AttackRight")
	else:
		animation_player.play("AttackLeft")


func _hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not bodies_hit.has(body):
		body.get_node("HealthComponent").take_damage(get_parent().damage)
		bodies_hit.append(body)

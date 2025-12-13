extends EnemyState

var player:CharacterBody2D
var direction_to_player

@export var attack_distance := 50
@export var loose_player_distance := 700

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]
	direction_to_player = player.global_position.x - get_parent().global_position.x
	if direction_to_player > 0:
		direction_to_player = 1
	elif direction_to_player <= 0:
		direction_to_player = -1
	get_parent().change_animtion(animation_sprite)
	enemy_body = get_parent().get_parent()

func phys_update(_delta: float):
	enemy_body.position.x += get_parent().move_speed * _delta * direction_to_player
	if abs(player.global_position.x - get_parent().global_position.x) <= attack_distance:
		finished.emit("EnemyIdle", {"player": player})
	elif abs(player.global_position.x - get_parent().global_position.x) >= loose_player_distance:
		finished.emit("EnemyIdle")

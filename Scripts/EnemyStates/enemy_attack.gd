extends EnemyState

var attack:Node
var attacks_list:Array
var attack_number := 0
##If true attacks are done in order else they are picked at random
@export var sequens_attacks := false 




func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]
	attacks_list = get_children()
	animation_player.play("RESET")


func phys_update(_delta: float):
	if not animation_player.is_playing():
		animation_player.play("RESET")
		if sequens_attacks:
			next_attack()
		else:
			pick_random_attack()

func next_attack():
	var distance_to_player = abs(player.global_position.x - get_parent().global_position.x)
	var current_attack = attacks_list[attack_number]
	if current_attack.min_range > distance_to_player:
		finished.emit("EnemyChase", {"temp attack range": current_attack.min_range, "player": player, "reverse":true})
		return
	elif distance_to_player > current_attack.max_range:
		finished.emit("EnemyChase", {"temp attack range": current_attack.max_range, "player": player})
		return
	current_attack.attack(player, animation_player, enemy_body)
	if attacks_list.size()-1 > attack_number:
		attack_number += 1
	else:
		attack_number = 0

func pick_random_attack():
	var distance_to_player = abs(player.global_position.x - get_parent().global_position.x)
	var current_attack = get_children().pick_random()
	if attack:
		current_attack = attack
	if current_attack.min_range > distance_to_player:
		finished.emit("EnemyChase", {"temp attack range": current_attack.max_range, "player": player, "reverse":true})
	elif distance_to_player > current_attack.max_range:
		finished.emit("EnemyChase", {"temp attack range": current_attack.max_range, "player": player})
		attack = current_attack
	else:
		current_attack.attack(player, animation_player, enemy_body)
		attack = null

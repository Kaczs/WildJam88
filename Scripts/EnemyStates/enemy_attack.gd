extends EnemyState

var attack:Node
var attacks_list:Array
var bodies_hit:Array
var attack_number := 0
##If true attacks are done in order else they are picked at random
@export var sequens_attacks := false 	

func enter(_previous_state_path: String, _data:Dictionary):
	brain_component.hit_box.connect("body_entered", _hit_box_body_entered)
	player = _data["player"]
	attacks_list = get_children()

func phys_update(_delta: float):
	enemy_body.velocity.y = 0
	if not animation_player.is_playing():
		bodies_hit.clear()
		animation_player.play("RESET")
		if sequens_attacks:
			next_attack()
		else:
			pick_random_attack()
	enemy_body.velocity.y = gravity
	enemy_body.move_and_slide()

func next_attack():
	var distance_to_player = abs(player.global_position.x - brain_component.global_position.x)
	var current_attack = attacks_list[attack_number]
	if current_attack.min_range > distance_to_player:
		finished.emit("EnemyChase", {"temp attack range": current_attack.min_range, "player": player, "reverse":true})
		return
	elif distance_to_player > current_attack.max_range:
		finished.emit("EnemyChase", {"temp attack range": current_attack.max_range, "player": player})
		return
	current_attack.attack(player, animation_player, enemy_body, brain_component.damage)
	if attacks_list.size()-1 > attack_number:
		attack_number += 1
	else:
		attack_number = 0

func pick_random_attack():
	var distance_to_player = abs(player.global_position.x - brain_component.global_position.x)
	var current_attack = get_children().pick_random()
	if attack:
		current_attack = attack
	if current_attack.min_range > distance_to_player:
		finished.emit("EnemyChase", {"temp attack range": current_attack.min_range, "player": player, "reverse":true})
		attack = current_attack
	elif distance_to_player > current_attack.max_range:
		finished.emit("EnemyChase", {"temp attack range": current_attack.max_range, "player": player})
		attack = current_attack
	else:
		current_attack.attack(player, animation_player, enemy_body, brain_component.damage)
		attack = null

func _hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not bodies_hit.has(body):
		body.get_node("HealthComponent").take_damage(brain_component.damage)
		bodies_hit.append(body)

func exit() -> void:
	brain_component.hit_box.disconnect("body_entered", _hit_box_body_entered)

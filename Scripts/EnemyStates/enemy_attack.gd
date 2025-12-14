extends EnemyState

@onready var timer:Timer = $Timer
var facing:bool

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]

func phys_update(_delta: float):
	if not timer.is_stopped():
		return
	var direction_to_player = player.global_position.x - get_parent().global_position.x
	#check if player is in attack range if not go to chase state
	if abs(player.global_position.x - get_parent().global_position.x) >= get_parent().attack_distance:
		finished.emit("EnemyChase", {"player": player})
		return
	#get direction of player
	if direction_to_player > 0:
		facing = true
	elif direction_to_player <= 0:
		facing = false
	#set animation
	get_parent().change_animation(animation_sprite, facing)
	timer.start(get_parent().attack_cooldown)
	#wait for attack to complete 
	await timer.timeout
	#if player in range do damage
	if abs(player.global_position.x - get_parent().global_position.x) <= get_parent().attack_distance:
		var player_health:HealthComponent = player.find_child("HealthComponent")
		player_health.adjust_health(-get_parent().damage)

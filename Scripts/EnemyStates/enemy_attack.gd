extends EnemyState

@onready var timer:Timer = $Timer
var facing:bool

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]

func phys_update(_delta: float):
	if get_parent().health_component.current_health <= 0:
		finished.emit("EnemyDeath")
		return
	if not timer.is_stopped():
		return
	var direction_to_player = player.global_position.x - get_parent().global_position.x
	if abs(player.global_position.x - get_parent().global_position.x) >= get_parent().attack_distance:
		finished.emit("EnemyChase", {"player": player})
		return
	if direction_to_player > 0:
		facing = true
	elif direction_to_player <= 0:
		facing = false
	get_parent().change_animation(animation_sprite, facing)
	timer.start(get_parent().attack_cooldown)
	await timer.timeout
	if abs(player.global_position.x - get_parent().global_position.x) <= get_parent().attack_distance:
		var player_health:HealthComponent = player.find_child("HealthComponent")
		player_health.take_damage(get_parent().damage)

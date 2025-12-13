extends EnemyState

@export var attack_cooldown:float = 0.5
@export var attack_distance:int = 100
@onready var timer:Timer = $Timer

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]

func phys_update(_delta: float):
	if not timer.is_stopped():
		return
	if abs(player.global_position.x - get_parent().global_position.x) >= attack_distance:
		finished.emit("EnemyChase", {"player": player})
	get_parent().change_animation(animation_sprite)
	timer.start(attack_cooldown)
	print("attack start")
	await timer.timeout
	print("attack done")
	if abs(player.global_position.x - get_parent().global_position.x) <= attack_distance:
		var player_health:HealthComponent = player.find_child("HealthComponent")
		player_health.adjust_health(-get_parent().damage)
	

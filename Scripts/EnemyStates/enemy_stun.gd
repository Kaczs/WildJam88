extends EnemyState

@onready var timer:Timer =$Timer

func enter(_previous_state_path: String, _data:Dictionary):
	timer.start(_data["stun duration"])
	get_parent().change_animation(animation_sprite)

func _on_timer_timeout() -> void:
	finished.emit("Idle")

func phys_update(_delta: float):
	if get_parent().health_component.current_health <= 0:
		finished.emit("EnemyDeath")
		return

func exit() -> void:
	timer.stop()

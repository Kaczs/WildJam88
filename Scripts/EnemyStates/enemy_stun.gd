extends EnemyState

@onready var timer:Timer =$Timer

func enter(_previous_state_path: String, _data:Dictionary):
	timer.start(_data["stun duration"])
	get_parent().change_animation(animation_sprite)

func _on_timer_timeout() -> void:
	finished.emit("EnemyReturn")

func exit() -> void:
	#ensuers that if the enemy dies befor timer timout that _on_timer_timeout is not called
	timer.stop()

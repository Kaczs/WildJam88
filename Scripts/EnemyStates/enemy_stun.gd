extends EnemyState

@onready var timer:Timer =$Timer
var stunned:=false


func enter(_previous_state_path: String, _data:Dictionary):
	stunned = true
	timer.start(_data["stun duration"])
	animation_player.play(animation_sprite)

func _on_timer_timeout() -> void:
	if not stunned:
		push_warning(enemy_body.name + " Tried to leveave stun while not stunned")
		return
	finished.emit("EnemyReturn")
	print("HEY THE TIMER TIMED OUT")

func exit() -> void:
	stunned = false
	#ensuers that if the enemy dies befor timer timout that _on_timer_timeout is not called
	timer.stop()

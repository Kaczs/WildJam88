extends EnemyState

@export var animation_sprite2:String
@onready var timer:Timer =$Timer
var parried:=false


func enter(_previous_state_path: String, _data:Dictionary):
	timer.start(_data["stun duration"])
	if _data.has("parried"):
		animation_player.play(animation_sprite2)
	else:
		animation_player.play(animation_sprite)

func phys_update(_delta: float):
	enemy_body.velocity.y = gravity
	enemy_body.move_and_slide()

func _on_timer_timeout() -> void:
	finished.emit("EnemyReturn")
	print("HEY THE TIMER TIMED OUT")

func exit() -> void:
	parried = false
	#ensuers that if the enemy dies befor timer timout that _on_timer_timeout is not called
	timer.stop()

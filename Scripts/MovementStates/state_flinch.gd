## This state should probably have a fallback just in case the idle transfer doesnt work
extends MovementState

func enter(_previous_state_path: String, _data := {}):
	# cancel out any momentum
	player_body.velocity.x = 0
	animation_player.play("flinch")

func phys_update(_delta: float):
	player_body.velocity.y += gravity * _delta
	player_body.move_and_slide()

func exit() -> void:
	pass

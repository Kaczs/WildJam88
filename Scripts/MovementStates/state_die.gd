extends MovementState

func enter(_previous_state_path: String):
	animation_player.play("die")
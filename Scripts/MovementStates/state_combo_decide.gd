extends MovementState
var falling_factor := 2.0

func enter(_previous_state_path: String, _data := {}):
	parent.advance_combo()

func phys_update(_delta: float):
	pass

extends EnemyState


func enter(_previous_state_path: String, _data:Dictionary):
	collider.set_deferred("disabled", true)

func exit() -> void:
	collider.set_deferred("disabled", false)

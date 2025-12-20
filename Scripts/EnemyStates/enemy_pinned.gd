extends EnemyState


func enter(_previous_state_path: String, _data:Dictionary):
	collider.set_deferred("disabled", true)

func _physics_process(delta):
	# Dont do anything let spear control movement
	pass

func exit() -> void:
	collider.set_deferred("disabled", false)
	

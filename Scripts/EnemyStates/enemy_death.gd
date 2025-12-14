extends EnemyState

@export var colider:CollisionShape2D

func enter(_previous_state_path: String, _data:Dictionary):
	enemy_body.gravity_scale = 0
	get_parent().change_animation(animation_sprite)
	colider.set_deferred("disabled", true)

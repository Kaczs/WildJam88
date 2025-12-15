extends EnemyState

@export var colider:CollisionShape2D

func _ready() -> void:
	if not colider:
		await get_parent().get_parent().ready
		colider = enemy_body.get_node("CollisionShape2D")


func enter(_previous_state_path: String, _data:Dictionary):
	#if we dont disable gravity the we will fall through the floor when the colider is diabled
	#could do this by changing the colision mask to let the player through and stay on the floor
	enemy_body.gravity_scale = 0
	get_parent().change_animation(animation_sprite)
	#this allows the player to walk through deffeted enemies
	colider.set_deferred("disabled", true)

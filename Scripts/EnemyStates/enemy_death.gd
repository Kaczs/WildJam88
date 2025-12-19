extends EnemyState

@export var collider:CollisionShape2D

func enter(_previous_state_path: String, _data:Dictionary):
	if enemy_body != null:
		collider = enemy_body.find_child("Hurtbox")
	#if we dont disable gravity the we will fall through the floor when the colider is diabled
	#could do this by changing the colision mask to let the player through and stay on the floor
	animation_player.play(animation_sprite)
	#this allows the player to walk through deffeted enemies
	collider.set_deferred("disabled", true)

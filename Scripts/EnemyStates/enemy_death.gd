class_name EnemyDeath extends EnemyState

func enter(_previous_state_path: String, _data:Dictionary):
	animation_player.play(animation_sprite)
	#this allows the player to walk through deffeted enemies
	collider.set_deferred("disabled", true)

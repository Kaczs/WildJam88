extends Node

const max_range := 150
const min_range := 0

func attack(player:CharacterBody2D, animation_player:AnimationPlayer, enemy:RigidBody2D):
	#gets direction of player then plays the corresponding animation
	if player.global_position.x - enemy.global_position.x > 0:
		animation_player.play("AttackRight")
	else:
		animation_player.play("AttackLeft")

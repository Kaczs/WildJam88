extends Node

const max_range := 1000
const min_range := 0

@export var speed := 300
@export var projectile:PackedScene = load("res://Scenes/Enemies/Enemy Attacks/Attack Scenes/projectile.tscn")

@export var sprite:Node2D


func attack(player:CharacterBody2D, animation_player:AnimationPlayer, enemy:RigidBody2D):
	if not sprite:
		sprite = enemy.get_node("AnimatedSprite2D")
	var arrow:Projectile = projectile.instantiate()
	var angle_to_player = enemy.position.angle_to_point(player.position)
	var direction_to_player = player.global_position.x - enemy.global_position.x
	if direction_to_player > 0:
		animation_player.play("RangeAttack")
		sprite.set_flip_h(false)
	elif direction_to_player <= 0:
		animation_player.play("RangeAttack")
		sprite.set_flip_h(true)
	arrow.speed = Vector2.RIGHT.rotated(angle_to_player) * speed
	arrow.global_position = enemy.global_position
	arrow.rotation = angle_to_player
	arrow.damage = enemy.get_node("EnemyBrainComponent").damage
	await animation_player.summon
	get_node("/root").add_child(arrow)
	
	

extends Node

const max_range := 1000
const min_range := 0

@export var speed := 300
@export var projectile:PackedScene = load("res://Scenes/Enemies/Enemy Attacks/Attack Scenes/arrow.tscn")

@export var sprite:Node2D
@export var spawn_offset := Vector2.ZERO


func attack(player:CharacterBody2D, animation_player:AnimationPlayer, enemy:RigidBody2D):
	if not sprite:
		sprite = enemy.get_node("EnemyBrainComponent").animated_sprite_2d
	var arrow:Projectile = projectile.instantiate()
	var angle_to_player = enemy.position.angle_to_point(player.position)
	var direction_to_player = player.global_position.x - enemy.global_position.x
	if direction_to_player > 0:
		animation_player.play("RangeAttack")
		sprite.set_flip_h(false)
		arrow.global_position = enemy.global_position + Vector2(spawn_offset.x, spawn_offset.y)
	elif direction_to_player <= 0:
		animation_player.play("RangeAttack")
		sprite.set_flip_h(true)
		arrow.global_position = enemy.global_position + Vector2(spawn_offset.x, -spawn_offset.y)
	arrow.speed = Vector2.RIGHT.rotated(angle_to_player) * speed
	arrow.rotation = angle_to_player
	arrow.damage = enemy.get_node("EnemyBrainComponent").damage
	await animation_player.summon
	get_node("/root").add_child(arrow)
	
	

extends Node2D

@export var enemy:RigidBody2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var enemy_health:HealthComponent = enemy.get_node("HealthComponent")
		enemy_health.adjust_health(-50)

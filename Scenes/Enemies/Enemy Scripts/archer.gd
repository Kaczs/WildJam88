extends RigidBody2D

var projectile:PackedScene = load("res://Scenes/Enemy Components/projectile.tscn")

@export var force_of_shot := Vector2(100, 100)

func shoot():
	var arrow:Projectile = projectile.instantiate()
	

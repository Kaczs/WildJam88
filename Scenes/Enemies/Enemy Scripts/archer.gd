extends RigidBody2D

var projectile:PackedScene = load("res://Scenes/Enemy Components/projectile.tscn")

@export var force_of_shot := 700
@export var direction:int


func hit_player():
	var arrow:Projectile = projectile.instantiate()
	arrow.force = force_of_shot * direction
	arrow.global_position = self.global_position
	arrow.damage = get_node("EnemyBrainComponent").damage
	get_parent().add_child(arrow)

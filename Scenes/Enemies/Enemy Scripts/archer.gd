extends RigidBody2D

var projectile:PackedScene = load("res://Scenes/Enemy Components/projectile.tscn")

@export var force_of_shot := 700
var player:CharacterBody2D


func hit_player():
	var arrow:Projectile = projectile.instantiate()
	var angle_to_player = self.position.angle_to_point(player.position)
	arrow.force = Vector2.RIGHT.rotated(angle_to_player) * force_of_shot
	arrow.global_position = self.global_position
	arrow.rotation = angle_to_player
	arrow.damage = get_node("EnemyBrainComponent").damage
	get_parent().add_child(arrow)

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body

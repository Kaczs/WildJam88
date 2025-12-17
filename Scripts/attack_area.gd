extends Area2D

signal dealt_damage
## This contains the numbers we'll need for damage/hitsun, adjusted by the animation player
var move_component:MovementComponent

func _ready():
	move_component = owner.find_child("MovementComponent")

func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	for health_component:HealthComponent in body.find_children("*", "HealthComponent"):
		health_component.take_damage(move_component.attack_damage * move_component.damage_mod)
		print("Player is dealing damage to: " + body.name)
		dealt_damage.emit()
		HitstopManager.create_hitstop(move_component.hitstop)

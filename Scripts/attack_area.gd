extends Area2D

signal dealt_damage

func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	for health_component:HealthComponent in body.find_children("*", "HealthComponent"):
		if not body.is_in_group("player"):
			health_component.take_damage(50)
			print("Dealing damage to: " + body.name)
			dealt_damage.emit()
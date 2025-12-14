extends Area2D





func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	for health_component:HealthComponent in body.owner.find_children("*", "HealthComponent"):
		if not body.is_in_group("player") :
			health_component.take_damage(5)
			print("Dealing damage to: " + health_component.owner.name)

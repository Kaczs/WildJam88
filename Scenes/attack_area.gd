extends Area2D



func _on_area_entered(area: Area2D) -> void:
	print("Hit m8 there's a guy ere")
	for health_component:HealthComponent in area.owner.find_children("*", "HealthComponent"):
		health_component.take_damage(5)
		print("Dealing damage to: " + health_component.owner.name)
	# is he me? or on my team
	# does he have health?
	# 

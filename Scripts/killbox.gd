extends Area2D



func _on_body_entered(body: Node2D) -> void:
	var health:HealthComponent = body.find_child("HealthComponent")
	if health != null:
		health.take_damage(9999999)
	

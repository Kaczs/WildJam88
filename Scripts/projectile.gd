class_name Projectile extends RigidBody2D

@export var force := Vector2(0,700)
@export var damage:int
@export var despawn_timer := 3.3

func _ready() -> void:
	apply_central_force(force)
	$DespawnTimer.start(despawn_timer)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.get_node("HealthComponent").deal_damage(damage)
		$AnimationPlayer.play("Hit")

func die():
	self.queue_free()

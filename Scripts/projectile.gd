class_name Projectile extends Node2D

@export var force:Vector2
@export var damage:int
@export var despawn_timer := 3.3

func _ready() -> void:
	$DespawnTimer.start(despawn_timer)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.get_node("HealthComponent").take_damage(damage)
		$AnimationPlayer.play("Hit")

func die():
	self.queue_free()

func _physics_process(delta: float) -> void:
	position += force * delta

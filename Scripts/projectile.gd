class_name Projectile extends Node2D

@export var speed:Vector2
@export var damage:int
@export var despawn_timer := 3.3

func _ready() -> void:
	$DespawnTimer.start(despawn_timer)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		speed = Vector2.ZERO
		body.get_node("HealthComponent").take_damage(damage)
		$AnimationPlayer.play("Hit")
	elif body == StaticBody2D:
		speed = Vector2.ZERO
		die()
		$AnimationPlayer.play("Hit")

func die():
	self.queue_free()

func _physics_process(delta: float) -> void:
	position += speed * delta

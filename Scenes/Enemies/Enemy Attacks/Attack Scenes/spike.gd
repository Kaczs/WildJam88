class_name Spike extends Node2D

var damage:int
var bodies_hit:Array

func _ready() -> void:
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		self.global_position = $RayCast2D.get_collision_point()
		$AnimationPlayer.play("spike eruption")
	else:
		die()


func die():
	self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not bodies_hit.has(body):
		body.get_node("HealthComponent").take_damage(damage)
		bodies_hit.append(body)

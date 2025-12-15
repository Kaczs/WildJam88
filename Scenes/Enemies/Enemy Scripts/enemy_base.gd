extends RigidBody2D

@onready var hit_box = $HitBox
@onready var brain = $EnemyBrainComponent


#called by animation player
func hit_player():
	for body in hit_box.get_overlapping_bodies():
		if body.is_in_group("player"):
			var player_health:HealthComponent = body.get_node("HealthComponent")
			player_health.take_damage(brain.damage)

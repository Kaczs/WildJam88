extends EnemyState

var area:Area2D



func enter(_previous_state_path: String, _data:Dictionary):
	area = get_parent().area
	if not area.body_entered.is_connected(body_entered):
		area.body_entered.connect(body_entered)
	get_parent().change_animation(animation_sprite)
	area.set_monitoring(true)
	for body in area.get_overlapping_bodies():
		if body.is_in_group("player"):
			finished.emit("EnemyChase", {"player": body})
			return

func body_entered(body:Node2D):
	if body.is_in_group("player"):
		finished.emit("EnemyChase", {"player": body})

func exit() -> void:
	set_deferred("area.set_monitoring", false)

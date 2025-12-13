extends EnemyState

var area:Area2D

func _ready() -> void:
	if get_parent().area:
		area = get_parent().area
	else:
		push_error("I (" + str(self) + ") Cant get parents area variable")
	area.body_entered.connect(body_entered)

func enter(_previous_state_path: String, _data:Dictionary):
	get_parent().change_animtion(animation_sprite)
	for body in area.get_overlapping_bodies():
		if body.is_in_group("player"):
			finished.emit("chase", {"player": body})
			return
	area.set_monitoring(true)

func body_entered(body:Node2D):
	if body.is_in_group("player"):
		finished.emit("EnemyChase", {"player": body})

func exit() -> void:
	area.set_monitoring(false)

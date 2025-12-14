extends EnemyState


@export var player_detector_range:int = 1000

var area:Area2D

func enter(_previous_state_path: String, _data:Dictionary):
	area = get_parent().player_detector
	if not area.body_entered.is_connected(body_entered):
		area.body_entered.connect(body_entered)
	#set animation
	get_parent().change_animation(animation_sprite)
	#monitoring is toggled on (when state is active) and off (when inactive) so that we can listen for the on body entered signal
	area.set_monitoring(true)
	#check if player is in PlayerDetector
	for body in area.get_overlapping_bodies():
		if body.is_in_group("player"):
			finished.emit("EnemyChase", {"player": body})
			return

func body_entered(body:Node2D):
	if body.is_in_group("player"):
		finished.emit("EnemyChase", {"player": body})

func exit() -> void:
	#this is call deferred because the engine yelled at me when I dint do it
	set_deferred("area.set_monitoring", false)

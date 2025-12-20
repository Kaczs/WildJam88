extends EnemyState

var area:Area2D
var is_current_state:bool

func enter(_previous_state_path: String, _data:Dictionary):
	is_current_state = true
	area = brain_component.player_detector
	if not area.body_entered.is_connected(body_entered):
		area.body_entered.connect(body_entered)
	#set animation
	animation_player.play(animation_sprite)
	#monitoring is toggled on (when state is active) and off (when inactive) so that we can listen for the on body entered signal
	area.get_child(0).set_disabled(false)
	#check if player is in PlayerDetector
	for body in area.get_overlapping_bodies():
		if body.is_in_group("player"):
			finished.emit("EnemyChase", {"player": body})
			return
	area.get_child(0).call_deferred("set_disabled",false)

func body_entered(body:Node2D):
	if body.is_in_group("player"):
		finished.emit("EnemyChase", {"player": body})

func phys_update(_delta: float):
	enemy_body.velocity.y = gravity
	enemy_body.move_and_slide()

func exit() -> void:
	area.get_child(0).call_deferred("set_disabled",true)
	is_current_state = false

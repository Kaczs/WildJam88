extends EnemyState

var direction_to_player
var facing_left:bool
@onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]
	direction_to_player = player.global_position.x - get_parent().global_position.x
	if direction_to_player > 0:
		direction_to_player = 1
		facing_left = true
	elif direction_to_player <= 0:
		direction_to_player = -1
		facing_left = false
	get_parent().change_animation(animation_sprite, facing_left)
	enemy_body = get_parent().get_parent()
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	audio.play()
	audio.set_stream_paused(false)


func phys_update(_delta: float):
	enemy_body.position.x += get_parent().move_speed * _delta * direction_to_player
	
	if abs(player.global_position.x - get_parent().global_position.x) <= get_parent().attack_distance:
		finished.emit("EnemyAttack", {"player": player})
	elif abs(player.global_position.x - get_parent().global_position.x) >= get_parent().loose_player_distance:
		finished.emit("EnemyIdle")

func exit() -> void:
	audio.set_stream_paused(true)

func _on_audio_stream_player_2d_finished() -> void:
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	audio.play()

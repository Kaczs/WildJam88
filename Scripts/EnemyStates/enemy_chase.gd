extends EnemyState

var play_sound:=true
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
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	audio.play()
	play_sound = true


func phys_update(_delta: float):
	if abs(player.global_position.x - get_parent().global_position.x) <= get_parent().attack_distance:
		finished.emit("EnemyAttack", {"player": player})
	elif abs(player.global_position.x - get_parent().global_position.x) >= get_parent().loose_player_distance:
		finished.emit("EnemyReturn")
	enemy_body.position.x += get_parent().move_speed * _delta * direction_to_player

func exit() -> void:
	play_sound = false

func _on_audio_stream_player_2d_finished() -> void:
	if not play_sound:
		return
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	audio.play()

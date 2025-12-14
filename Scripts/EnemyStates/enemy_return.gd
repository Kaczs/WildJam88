extends EnemyState

var play_sound:=true
var starting_postion:Vector2
var direction_to_start
var facing_left
var area:Area2D

@onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D

func enter(_previous_state_path: String, _data:Dictionary):
	if get_parent().health_component.current_health <= 0:
		finished.emit("EnemyDeath")
		return
	area = get_parent().area
	if not area.body_entered.is_connected(body_entered):
		area.body_entered.connect(body_entered)
	starting_postion = get_parent().starting_position
	direction_to_start = starting_postion.x - get_parent().global_position.x
	if direction_to_start > 0:
		direction_to_start = 1
		facing_left = true
	elif direction_to_start <= 0:
		direction_to_start = -1
		facing_left = false
	get_parent().change_animation(animation_sprite, facing_left)
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	audio.play()
	play_sound = true

func phys_update(_delta: float):
	var distacne_to_start = starting_postion.x - get_parent().global_position.x
	#
	if distacne_to_start < 30 and -30 < distacne_to_start:
		finished.emit("EnemyIdle")
	enemy_body.position.x += get_parent().move_speed * _delta * direction_to_start

func _on_audio_stream_player_2d_finished() -> void:
	if not play_sound:
		return
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	audio.play()

func body_entered(body:Node2D):
	if body.is_in_group("player"):
		finished.emit("EnemyChase", {"player": body})

func exit() -> void:
	play_sound = false

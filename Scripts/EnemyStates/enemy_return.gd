extends EnemyState

var starting_postion:Vector2
var direction_to_start
var facing_left
var area:Area2D

@onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D

func enter(_previous_state_path: String, _data:Dictionary):
	area = get_parent().player_detector
	if not area.body_entered.is_connected(body_entered):
		area.body_entered.connect(body_entered)
	starting_postion = get_parent().starting_position
	#we use only starting_postion.x so that if the enemy has fallen off a platform they can go to close to there stating pos
	#TODO make enemy teleport if not on screen and at starting_postion.x
	direction_to_start = starting_postion.x - get_parent().global_position.x
	if direction_to_start > 0:
		direction_to_start = 1
		facing_left = true
	elif direction_to_start <= 0:
		direction_to_start = -1
		facing_left = false
	get_parent().change_animation(animation_sprite, facing_left)
	#start playing foot step sound here then will play the rest from the _on_audio_stream_player_2d_finished function
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	audio.play()
	audio.set_stream_paused(false)

func phys_update(_delta: float):
	var distacne_to_start = starting_postion.x - get_parent().global_position.x
	#adds a deadzone to the start posision 
	if distacne_to_start < 30 and -30 < distacne_to_start:
		finished.emit("EnemySearch")
	enemy_body.position.x += get_parent().move_speed * _delta * direction_to_start

func _on_audio_stream_player_2d_finished() -> void:
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	audio.play()

func body_entered(body:Node2D):
	if body.is_in_group("player"):
		finished.emit("EnemyChase", {"player": body})

func exit() -> void:
	audio.set_stream_paused(true)

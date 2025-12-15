extends EnemyState

var is_current_state:=true
var direction_to_player
var facing_left:bool
@onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"]
	#gets the derection of player and sets animation
	direction_to_player = player.global_position.x - get_parent().global_position.x
	if direction_to_player > 0:
		direction_to_player = 1
		facing_left = true
	elif direction_to_player <= 0:
		direction_to_player = -1
		facing_left = false
	get_parent().change_animation(animation_sprite, facing_left)
	enemy_body = get_parent().get_parent()
	#start playing foot step sound here then will play the rest from the _on_audio_stream_player_2d_finished function
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	is_current_state = true
	audio.play()


func phys_update(_delta: float):
	enemy_body.position.x += get_parent().move_speed * _delta * direction_to_player
	
	if abs(player.global_position.x - get_parent().global_position.x) <= get_parent().attack_distance:
		finished.emit("EnemyAttack", {"player": player})
	elif abs(player.global_position.x - get_parent().global_position.x) >= get_parent().lose_player_distance:
		finished.emit("EnemyReturn")
	enemy_body.position.x += get_parent().move_speed * _delta * direction_to_player

func exit() -> void:
	is_current_state = false

func _on_audio_stream_player_2d_finished() -> void:
	#update player direction
	#we update the player direction here because we dont need to check often
	direction_to_player = player.global_position.x - get_parent().global_position.x
	if direction_to_player > 0:
		direction_to_player = 1
		facing_left = true
	elif direction_to_player <= 0:
		direction_to_player = -1
		facing_left = false
	if is_current_state:
		audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
		audio.play()
		#we only updata animation if this is curent state
		get_parent().change_animation(animation_sprite, facing_left)

extends EnemyState

var attack_range:int
var is_current_state:=true
var direction_to_player
var facing_left:bool
var reverse:bool
var current_direction:int
@onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D

func enter(_previous_state_path: String, _data:Dictionary):
	player = _data["player"] #body
	reverse = _data.has("reverse") #bool
	#gets the derection of player and sets animation
	direction_to_player = player.global_position.x - enemy_body.global_position.x
	if direction_to_player > 0:
		direction_to_player = 1
		facing_left = false
	elif direction_to_player <= 0:
		direction_to_player = -1
		facing_left = true
	animation_player.play(animation_sprite)
	sprite_2d.flip_h = facing_left
	#start playing foot step sound here then will play the rest from the _on_audio_stream_player_2d_finished function
	audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
	is_current_state = true
	audio.play()
	if _data.has("temp attack range"):
		attack_range = _data["temp attack range"]
	else:
		attack_range = brain_component.attack_distance


func phys_update(_delta: float):
	direction_to_player = player.global_position.x - brain_component.global_position.x
	if direction_to_player > 0:
		direction_to_player = 1
		facing_left = false
	elif direction_to_player <= 0:
		direction_to_player = -1
		facing_left = true
	if reverse:
		enemy_body.velocity.x = brain_component.move_speed * -direction_to_player
		if abs(player.global_position.x - brain_component.global_position.x) >= attack_range:
			finished.emit("EnemyAttack", {"player": player})
	else:
		enemy_body.velocity.x = brain_component.move_speed * direction_to_player
		if abs(player.global_position.x - brain_component.global_position.x) <= attack_range:
			finished.emit("EnemyAttack", {"player": player})
		elif abs(player.global_position.x - brain_component.global_position.x) >= brain_component.lose_player_distance:
			finished.emit("EnemyReturn")
	enemy_body.velocity.y = gravity
	enemy_body.move_and_slide()

func exit() -> void:
	is_current_state = false

func _on_audio_stream_player_2d_finished() -> void:
	if is_current_state:
		audio.stream = load(SoundFiles.snowy_footsteps.pick_random())
		audio.play()
		#we only updata animation if this is curent state
		sprite_2d.flip_h = facing_left

func move():
	current_direction = direction_to_player

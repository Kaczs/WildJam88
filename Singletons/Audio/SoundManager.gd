extends Node

var music_player:AudioStreamPlayer
var curent_music_track:int = 0

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.stream = load(SoundFiles.music[curent_music_track])
	music_player.bus = "Music"
	music_player.autoplay = true
	music_player.finished.connect(func():
		music_player.play()
		)
	self.add_child(music_player)

func play_2d(audio:String, location:Node, bus:String = "SFX", max_distance:int = 1000, attenuation:float = 2, volume:int = 0):
	var new:AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	new.stream = load(audio)
	new.bus = bus
	new.volume_db = volume
	new.pitch_scale = randf_range(0.9, 1.1)
	new.max_distance = max_distance 
	new.attenuation = attenuation
	new.autoplay = true
	new.finished.connect(func():
		new.queue_free()
		)
	location.add_child(new)

func play_global(audio:String, bus:String = "SFX", volume:int = 0):
	var new:AudioStreamPlayer = AudioStreamPlayer.new()
	new.stream = load(audio)
	new.bus = bus
	new.volume_db = volume
	new.pitch_scale = randf_range(0.9, 1.1)
	new.autoplay = true
	new.finished.connect(func():
		new.queue_free()
		)
	self.add_child(new)


func next_track(reset:= false):
	if reset:
		curent_music_track = 0
	else:
		curent_music_track = clampi(curent_music_track + 1, 0, 2)
	music_player.stream = load(SoundFiles.music[curent_music_track])
	music_player.play()

extends Node


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


func play_global(audio:String, location:Node, bus:String = "SFX", volume:int = 0):
	var new:AudioStreamPlayer = AudioStreamPlayer.new()
	new.stream = load(audio)
	new.bus = bus
	new.volume_db = volume
	new.pitch_scale = randf_range(0.9, 1.1)
	new.autoplay = true
	new.finished.connect(func():
		new.queue_free()
		)
	location.add_child(new)

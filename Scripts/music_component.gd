extends Node
@onready var player = get_tree().get_first_node_in_group("player")
@onready var impulsiveness_component:ImpulsivenessComponent = player.get_node("ImpulsivenessComponent")
var current_track = "track1"

func _ready():
	impulsiveness_component.connect("gained_impulsiveness", check_music)

func check_music(current_impulsiveness):
	if current_impulsiveness >= 66 and current_track != "track3":
		current_track = "track3"
		SoundManager.next_track()
		print("playing track3")
	elif current_impulsiveness >= 33 and current_track != "track2" and current_track != "track3":
		current_track = "track2"
		SoundManager.next_track()
		print("playing track2")
	elif current_impulsiveness < 33 and current_track != "track1":
		current_track = "track1"
		SoundManager.next_track(true)
		print("Playing track1")

extends ProgressBar
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	player.get_node("ImpulsivenessComponent")\
		.connect("gained_impulsiveness", update_ui)

func update_ui(amount):
	value = amount
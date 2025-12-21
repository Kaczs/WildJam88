extends ProgressBar
@onready var player = get_tree().get_first_node_in_group("player")
var health:HealthComponent

func _ready():
	health = player.find_child("HealthComponent")
	health.connect("on_hit", update_bar)
	update_bar(0, 300)

func update_bar(_stagger, current_health):
	value = ((float(health.current_health)/float(health.max_health)) * 100.0)

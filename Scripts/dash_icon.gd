extends TextureRect
@onready var player = get_tree().get_first_node_in_group("player")
@onready var impulsiveness_component:ImpulsivenessComponent = player.get_node("ImpulsivenessComponent")
@onready var move_component:MovementComponent = player.get_node("MovementComponent")
var on_cooldown := false
var unavailable := true
var cost := 66

func _process(_delta):
	# HACK, running out of time
	if move_component.radiantd_timer.time_left >= 0:
		self.modulate = Color.DARK_GRAY
	else:
		self.modulate = Color.WHITE
	if impulsiveness_component.current_impulsiveness >= cost:
		self.modulate = Color.WHITE
	else:
		self.modulate = Color.DARK_GRAY
	

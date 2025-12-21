extends ProgressBar
@onready var player = get_tree().get_first_node_in_group("player")
@onready var combo_text:Label

func _ready():
	var impulsiveness_component = player.get_node("ImpulsivenessComponent")
	impulsiveness_component.connect("gained_impulsiveness", update_bar)
	impulsiveness_component.connect("did_damage", update_combo_text)
	combo_text = get_node("ComboText")

func update_bar(amount):
	value = amount

func update_combo_text(amount:int):
	if amount == 0:
		combo_text.hide()
	else:
		combo_text.show()
	combo_text.text = (str(amount)+"x")

## This will manage the character's implusivness value, basically "point" score that unlocks
## new abilites as you beat the shit outta mobs. It'll listen for the various signals yield
## "points", calculate combo, and update ui
extends Node
var combo_factor:float = 1
var current_impulsiveness:float = 0
var combo_timer:Timer

signal gained_impulsiveness
@export var points_damage_taken: float
@export var points_damage_dealt: float
@export var combo_duration: float
@export var combo_factor_increase_amount:float

func _ready():
	# Need to connect the various signals
	combo_timer = get_node("ComboTimer")
	combo_timer.wait_time = combo_duration
	combo_timer.timeout.connect(reset_combo)
	get_parent().find_child("HealthComponent").connect("on_hit", took_damage)
	get_parent().find_child("AttackArea").connect("dealt_damage", dealt_damage)
	

func took_damage(_stagger, _current_health):
	add_points(points_damage_taken)

func dealt_damage():
	# Reset the combo duration, and start it if its not running
	combo_timer.start()
	# We dealt damage so increase how many points we get for doing more
	combo_factor += combo_factor_increase_amount
	print("Combo Factor is now: " + str(combo_factor))
	add_points(points_damage_dealt)

func add_points(amount):
	current_impulsiveness += (amount * combo_factor)
	gained_impulsiveness.emit(current_impulsiveness)
	# Have we unlocked a new skill?

## When the combo duration runs out, reset the factor.
func reset_combo():
	combo_factor = 1

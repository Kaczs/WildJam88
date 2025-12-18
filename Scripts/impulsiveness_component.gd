## This will manage the character's implusivness value, basically "point" score that unlocks
## new abilites as you beat the shit outta mobs. It'll listen for the various signals yield
## "points", calculate combo, and update ui
extends Node
var combo_score:int = 0
var current_impulsiveness:int = 0
signal gained_impulsiveness
@export var points_damage_taken: float
@export var points_damage_dealt: float

func _ready():
	# Need to connect the various signals
	get_parent().find_child("HealthComponent").connect("on_hit", took_damage)
	get_parent().find_child("AttackArea").connect("dealt_damage", dealt_damage)
	

func took_damage(_stagger, _current_health):
	add_points(points_damage_taken)

func dealt_damage():
	add_points(points_damage_dealt)

func add_points(amount):
	current_impulsiveness += amount
	gained_impulsiveness.emit(amount)

	# Are we are at new stage
	# update ui signal

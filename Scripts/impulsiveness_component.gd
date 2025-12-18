## This will manage the character's implusivness value, basically "point" score that unlocks
## new abilites as you beat the shit outta mobs. It'll listen for the various signals yield
## "points", calculate combo, and update ui
extends Node
var combo_score
var ui_bar
@export var points_damage_taken: float
@export var points_damage_dealt: float

func took_damage():
	pass

func dealt_damage():
	pass

func add_points():
	pass

func update_ui():
	pass


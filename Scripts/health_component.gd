class_name HealthComponent extends Node

@export var max_health := 100
var current_health

func _ready():
	current_health = max_health

## Adjust's health by the given value, provide negative value to deal damage, positive for healing
func adjust_health(amount):
	current_health += amount
	if current_health <= 0:
		print("I ded :" + get_parent().name)
		# if player change to die
		# if bot change to die state
		# if none of the above delete it (like static boxes for instance?)
	if current_health > max_health:
		current_health = max_health

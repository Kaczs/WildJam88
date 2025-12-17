class_name HealthComponent extends Node

@export var max_health := 100
var current_health:int

signal on_hit(stagger_duration:float, current_health:int)

func _ready():
	current_health = max_health

##Heal by the given value
func heal(amount):
	current_health += amount
	if current_health > max_health:
		current_health = max_health

##Deal damage by given amount
func take_damage(amount:int, stagger:float = 0):
	current_health -= amount
	on_hit.emit(stagger, current_health)

##Change max_health by given amount
func adjust_max_health(amount):
	max_health += amount
	if max_health <= 0:
		max_health = 1
		current_health = 1
		return
	if current_health > max_health:
		current_health = max_health

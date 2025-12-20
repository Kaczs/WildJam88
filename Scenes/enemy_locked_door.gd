extends Node2D
@export var enemies:Array[CharacterBody2D]
@export var open_texture:Texture2D
var brain_array:Array[EnemyBrainComponent]
var collider:StaticBody2D
var sprite:Sprite2D

func _ready():
	collider = find_child("StaticBody2D")
	sprite = find_child("Sprite2D")
	for enemy in enemies:
		var brain:EnemyBrainComponent = enemy.find_child("EnemyBrainComponent")
		if brain != null:
			brain.connect("enemy_died", check_to_open)
			brain_array.append(brain)

func check_to_open():
	for brain in brain_array:
		if brain.is_dead == true:
			pass
		else:
			return
	print("Door's Open")
	open_door()

func open_door():
	# Sprite arent aligned
	sprite.position.x += 124
	sprite.texture = open_texture
	collider.queue_free()

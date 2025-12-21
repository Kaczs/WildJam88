extends Node

@export var max_range := 2000
@export var min_range := 400

@export var damage_over_ride:int = 30
@export var over_ride_damage := true

var spike_scene:PackedScene = load("res://Scenes/Enemies/Enemy Attacks/Attack Scenes/spike.tscn")

func attack(player:CharacterBody2D, animation_player:AnimationPlayer, _enemy:CharacterBody2D, damage:int):
	var spike:Spike = spike_scene.instantiate()
	if over_ride_damage:
		spike.damage = damage_over_ride
	else:
		spike.damage = damage
	spike.show_behind_parent = true
	animation_player.play("Summon")
	await animation_player.summon
	spike.global_position = player.global_position
	player.get_parent().add_child(spike)
	

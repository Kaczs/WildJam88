extends Node

const max_range := 2000
const min_range := 400

@export var damage:int = 30

var spike_scene:PackedScene = load("res://Scenes/Enemies/Enemy Attacks/Attack Scenes/spike.tscn")

func attack(player:CharacterBody2D, animation_player:AnimationPlayer, _enemy:CharacterBody2D):
	var spike:Spike = spike_scene.instantiate()
	spike.damage = damage
	spike.show_behind_parent = true
	animation_player.play("Summon")
	await animation_player.summon
	spike.global_position = player.global_position
	player.get_parent().add_child(spike)

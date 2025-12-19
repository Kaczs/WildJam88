extends Node

const max_range := 700
const min_range := 400

@export var damage:int = 30

var spike_scene:PackedScene = load("res://Scenes/Enemies/Enemy Attacks/Attack Scenes/spike.tscn")

func attack(player:CharacterBody2D, animation_player:AnimationPlayer, _enemy:CharacterBody2D):
	var spike:Spike = spike_scene.instantiate()
	spike.position = Vector2(player.position.x, player.position.y + 200)
	spike.scale = Vector2(0.2,0.2)
	spike.damage = damage
	spike.show_behind_parent = true
	animation_player.play("Summon")
	await animation_player.summon
	player.get_parent().add_child(spike)

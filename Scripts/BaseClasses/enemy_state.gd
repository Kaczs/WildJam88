class_name EnemyState extends Node

@warning_ignore("unused_signal")
signal finished(next_state_path: String, data: Dictionary)
var player: CharacterBody2D
var enemy_body: RigidBody2D:
	get: return owner as RigidBody2D
var brain_component: EnemyBrainComponent:
	get: return get_parent() as EnemyBrainComponent
var animation_player:AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var animation_sprite:String
@onready var parent_sprite

## Called by the movement component update loop
func update(_delta: float):
	pass

## Called by the movement component on the physics update loop
func phys_update(_delta: float):
	pass

## Words 
func enter(_previous_state_path: String, _data:Dictionary):
	pass

## Called when changing the state away from this one, should clean up
func exit() -> void:
	pass

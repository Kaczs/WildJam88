class_name EnemyState extends Node

@warning_ignore("unused_signal")
signal finished(next_state_path: String, data: Dictionary)
var player: CharacterBody2D
var brain_component: EnemyBrainComponent:
	get: return get_parent() as EnemyBrainComponent
var enemy_body: RigidBody2D:
	get: return brain_component.enemy_body as RigidBody2D
var animation_player:AnimationPlayer:
	get: return brain_component.animation_player as AnimationPlayer
var sprite_2d:Sprite2D:
	get: return brain_component.sprite_2d as Sprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var animation_sprite:String

## Called by the movement component update loop
func update(_delta: float):
	pass

## Called by the movement component on the physics update loop
func phys_update(_delta: float):
	pass

## Words 
func enter(_previous_state_path: String, _data:Dictionary):
	if not enemy_body:
		push_error(owner.name + " var not made")
	if not brain_component:
		push_error(owner.name + " var not made")
	if not animation_player:
		push_error(owner.name + " var not made")

## Called when changing the state away from this one, should clean up
func exit() -> void:
	pass

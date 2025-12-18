## Base class for all states used by the movement component
class_name MovementState 
extends Node

@warning_ignore("unused_signal")
signal finished(next_state_path: String, data: Dictionary)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# These will be needed by nearly all the states
var parent: MovementComponent:
	get: return get_parent() as MovementComponent
var player_body: CharacterBody2D:
	get: return parent.player_body
var speed: float:
	get: return parent.move_speed
var jump_power: float:
	get: return parent.jump_power
var animation_player: AnimationPlayer:
	get: return parent.animation_player
var sprite: Sprite2D:
	get: return parent.player_sprite
var impulsiveness_component: ImpulsivenessComponent:
	get: return parent.impulsiveness_component

## Called by the movement component receiving unhandled input events.
func handle_input(_event: InputEvent):
	pass

## Called by the movement component update loop
func update(_delta: float):
	pass

## Called by the movement component on the physics update loop
func phys_update(_delta: float):
	pass

## Words 
func enter(_previous_state_path: String):
	pass

## Called when changing the state away from this one, should clean up
func exit() -> void:
	pass

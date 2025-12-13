## Base class for all states used by the movement component
class_name MovementState extends Node

@warning_ignore("unused_signal")
signal finished(next_state_path: String, data: Dictionary)
var player_body: CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var parent:MovementComponent = get_parent()

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

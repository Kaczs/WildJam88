## This component can hold multiple "MovementState" children and will handle moving between the states.
## Adding different states will give whatever you add this to different movement abilities, run, crouch, jump etc.
## Whatever you attach this to needs to be a CharacterBody2D. Additionally there should be a sprite 2d (animated  sprite actually)
## as a child of that rigidbody
class_name MovementComponent extends Node
var current_state: MovementState
var player_body: CharacterBody2D
var initial_state: MovementState = null
var animation_player: AnimationPlayer
var player_sprite: Sprite2D

@export var move_speed := 200.0
@export var jump_power := 1000.0
@export var attack_cooldown := 0.6

func _ready():
	# Set startup variables
	player_body = owner
	animation_player = owner.find_child("AnimationPlayer")
	player_sprite = owner.find_child("Sprite2D")
	if player_body is not CharacterBody2D:
		push_error("The owner of the MovementComponent must be a CharacterBody2D")
	# Grab the first state on the object if one wasn't set 
	if initial_state == null:
		if get_child_count() > 0:
			initial_state = get_child(0)
		else:
			push_error("Movement component has no assigned states")
	# Connect the finished signals of it's children
	for state_node: MovementState in find_children("*", "MovementState"):
		state_node.player_body = player_body
		state_node.finished.connect(transition_to_next_state)
	current_state = initial_state
	await owner.ready
	current_state.enter("")

func _unhandled_input(event: InputEvent):
	current_state.handle_input(event)

func _process(delta: float):
	current_state.update(delta)
	print(current_state.name)

func _physics_process(delta: float) -> void:
	current_state.phys_update(delta)

## Function will take a path to the state you want to transition to
## and will do that
func transition_to_next_state(target_state_path: String, _data: Dictionary = {}):
	# if the given node path is invalid return
	if not has_node(target_state_path):
		push_error("Tried to transition to state: " + target_state_path + " but it doesn't exist")
		return
	# Exit the current state, and start up the new one.
	var previous_state_path := current_state.name
	current_state.exit()
	current_state = get_node(target_state_path)
	current_state.enter(previous_state_path)


func _on_animated_sprite_2d_animation_finished() -> void:
	print("Done Animating")

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
var hit_box_area:Area2D
var particles:Node2D

@export var move_speed := 200.0
@export var jump_power := 1000.0
## This can be modified by upgrades and such to increase damage in a scaling way
@export var damage_mod := 1.0
## The animation player will change this based on how much damage an attack should do
## this allows for multiattack animations to have different damage
@export var attack_damage := 50.0
## Animation player should change the amount of hitstop an attack causes
@export var hitstop := 0.08
## This is the time that a player has to wait after performing an attack
## however if they land an attack they have the ability to forgo this delay
## and startup another attack depending on the one they hit
@export var attack_recovery := 0.16
## This bool is flipped to true when the hitbox deals damage, used in states to determine cancelling
@export var dealt_damage := false
## Flipped by the AnimationPlayer, generally when attacking to lend weight and forward motion
@export var slide_forward := false
@export var cannot_cancel := false

func _ready():
	# Set startup variables
	player_body = owner
	animation_player = owner.find_child("AnimationPlayer")
	player_sprite = owner.find_child("Sprite2D")
	hit_box_area = owner.find_child("AttackArea")
	hit_box_area = owner.find_child("AttackArea")
	particles = owner.find_child("Particles")
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
	# Reset to standard state before transitioning this is to ensure any parameters
	# that were unique to one animation are reset properly (like hitboxes)
	animation_player.play(&"RESET")
	animation_player.advance(0)
	# if the given node path is invalid return
	if not has_node(target_state_path):
		push_error("Tried to transition to state: " + target_state_path + " but it doesn't exist")
		return
	# Exit the current state, and start up the new one.
	var previous_state_path := current_state.name
	current_state.exit()
	current_state = get_node(target_state_path)
	current_state.enter(previous_state_path)

## Flip the characters hitbox, particles and so forth
## reset function on animationplayer will fix the flipped state
## when transitioning
func flip_character():
	hit_box_area.scale.x = -1
	particles.scale.x = -1

## This forces the state back to idle, generally called in the AnimationPlayer at the end of animations
## that dont loop or idle well
func force_idle():
	transition_to_next_state("StateIdle")

func _on_attack_area_dealt_damage() -> void:
	dealt_damage = true
	

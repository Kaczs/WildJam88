## This component can hold multiple "EnemyState" children and will handle moving between the states.
## Adding different states will give whatever you add this to different movement abilities, run, crouch, jump etc.
## Whatever you attach this to needs to be a CharacterBody2D. Additionally there should be a sprite 2d (animated  sprite actually)
## as a child of that rigidbody
extends Node2D
var current_state: EnemyState
var last_facing:bool
var starting_position:Vector2
@export var health_component:HealthComponent
@export var animation_player:AnimationPlayer
@export var animated_sprite_2d:AnimatedSprite2D
@export var enemy_body: RigidBody2D
@export var initial_state: EnemyState = null

@export var move_speed := 200.0
@export var damage := 5
@export var attack_cooldown := 0.5
@export var attack_distance := 100
@export var lose_player_distance := 500

@onready var area:Area2D = $"../Area2D"

func _ready():
	starting_position = self.get_global_position()
	enemy_body = get_parent()
	# Grab the first state on the object if one wasn't set 
	if initial_state == null:
		if get_child_count() > 0:
			initial_state = get_child(0)
		else:
			push_error("Movement component has no assigned states")
	# Connect the finished signals of it's children
	for state_node: EnemyState in find_children("*", "EnemyState"):
		state_node.enemy_body = enemy_body
		state_node.finished.connect(transition_to_next_state)
	current_state = initial_state
	await owner.ready
	if get_parent().has_node("HealthComponent"):
		var health:HealthComponent = get_parent().get_node("HealthComponent")
		health.on_hit.connect(enemy_hit)
	else:
		push_warning("can't find HealthComponent")
	current_state.enter("",{})

func _process(delta: float):
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.phys_update(delta)

## Function will take a path to the state you want to transition to
## and will do that
func transition_to_next_state(target_state_path: String, data: Dictionary = {}):
	# if the given node path is invalid return
	if not has_node(target_state_path):
		push_error("Tried to transition to state : " + target_state_path + " but it doesn't exist")
		return
	# Exit the current state, and start up the new one.
	var previous_state_path := current_state.name
	current_state.exit()
	current_state = get_node(target_state_path)
	current_state.enter(previous_state_path, data)

func change_animation(new_animation:String, facing_left:bool = last_facing):
	animation_player.play(new_animation)
	last_facing = facing_left
	if facing_left:
		animated_sprite_2d.set_flip_h(false)
	else:
		animated_sprite_2d.set_flip_h(true)

func enemy_hit(stagger_duration:int, is_dead:bool):
	if is_dead:
		transition_to_next_state("EnemyDeath")
		return
	transition_to_next_state("EnemyStun", {"stun duration": stagger_duration})

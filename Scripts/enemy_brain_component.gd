## This component can hold multiple "EnemyState" children and will handle moving between the states.
## Adding different states will give whatever you add this to different movement abilities, run, crouch, jump etc.
## Whatever you attach this to needs to be a CharacterBody2D. Additionally there should be a sprite 2d (animated  sprite actually)
## as a child of that rigidbody
class_name EnemyBrainComponent extends Node2D
var current_state: EnemyState
var last_facing:bool
var starting_position:Vector2
var enemy_body: CharacterBody2D
var health_component:HealthComponent
var animation_player:AnimationPlayer
var sprite_2d:Sprite2D
var player_detector:Area2D
var hit_box:Area2D
var hurt_box:CollisionShape2D #is also physics colider

var is_dead := false
signal enemy_died

@export var initial_state: EnemyState

@export_group("Stats")
@export var move_speed := 200.0 #if this is ever over 3000 the return state has a chnace to not stop at the start location
@export var damage := 5
@export_subgroup("detection")
@export var lose_player_distance := 500

func _ready():
	if not initial_state:
		initial_state = get_node("EnemySearch")
	enemy_body = owner
	health_component = owner.find_child("HealthComponent") 
	animation_player = owner.find_child("AnimationPlayer") 
	sprite_2d = owner.find_child("Sprite2D")
	player_detector = owner.find_child("PlayerDetector")
	hit_box = owner.find_child("HitBox")
	hurt_box = owner.find_child("Hurtbox")
	starting_position = self.get_global_position()
	# Grab the first state on the object if one wasn't set 
	if initial_state == null:
		if get_child_count() > 0:
			initial_state = get_child(0)
		else:
			push_error("Movement component has no assigned states")
	# Connect the finished signals of it's children
	for state_node: EnemyState in find_children("*", "EnemyState"):
		state_node.finished.connect(transition_to_next_state)
		state_node.animation_player = animation_player
	current_state = initial_state
	await owner.ready
	health_component.on_hit.connect(enemy_hit)
	print(animation_player)
	current_state.enter("",{})

func _process(delta: float):
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.phys_update(delta)

## Function will take a path to the state you want to transition to
## and will do that
func transition_to_next_state(target_state_path: String, data: Dictionary = {}):
	if is_dead and not target_state_path == "EnemyDeath":
		print(enemy_body.name + "cant revieve")
		return
	animation_player.play("RESET")
	animation_player.advance(0)
	print("Transitioning " + enemy_body.name + " to State: " + current_state.name)
	# if the given node path is invalid return
	if not has_node(target_state_path):
		push_error("Tried to transition to state : " + target_state_path + " but it doesn't exist")
		return
	# Exit the current state, and start up the new one.
	var previous_state_path := current_state.name
	current_state.exit()
	current_state = get_node(target_state_path)
	current_state.enter(previous_state_path, data)
	#print(current_state.name)

func enemy_hit(stagger_duration:float, current_health:int):
	SoundManager.play_2d(SoundFiles.enmey_hit, enemy_body, "SFX", 2000)
	if current_health <= 0:
		is_dead = true
	if is_dead:
		enemy_died.emit()
		transition_to_next_state("EnemyDeath")
	else:
		transition_to_next_state("EnemyStun", {"stun duration": stagger_duration})

func parry(stagger_duration:float):
	if current_state.name == "EnemyAttack" and not is_dead:
		call_deferred("transition_to_next_state", "EnemyStun", {"stun duration": stagger_duration, "parried":true})

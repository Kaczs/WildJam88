extends CharacterBody2D

@export var speed: float = 600.0
@export var pin_duration: float = 3.0

@onready var pickup_area: Area2D = $PickupArea
@onready var sprite:Sprite2D = $Sprite2D
@export var flipped:bool = false

var captured_enemies: Array[Node2D] = []
var pinned: bool = false

func _ready() -> void:
	if flipped == false:
		sprite.flip_h = true
	pickup_area.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	var collision:KinematicCollision2D = null
	# If we've hit the wall dont do anything
	if pinned:
		return
	if flipped == false:
		collision = move_and_collide(Vector2.RIGHT * speed * delta)
	else:
		collision = move_and_collide(Vector2.LEFT * speed * delta)
	# Have we collided with a wall?
	if collision:
		hit_wall()

# Spear ran over a guy
func _on_body_entered(body: Node2D) -> void:
	if pinned:
		return
	#if not body.is_in_group("enemies"):
	#    return
	if body in captured_enemies:
		return
	capture_enemy(body)

func capture_enemy(enemy: Node2D) -> void:
	var brain:EnemyBrainComponent = enemy.find_child("EnemyBrainComponent")
	captured_enemies.append(enemy)
	# store offset so enemies stay where they were grabbed
	# Change state so they dont do anything
	brain.transition_to_next_state("EnemyPinned")
	var y_value = enemy.global_position.y - global_position.y
	# reparent to spear
	enemy.get_parent().remove_child(enemy)
	call_deferred("add_child", enemy)
	# Offset enemy from the new parent
	if flipped == true:
		enemy.position = Vector2(-110,y_value)
	else:
		enemy.position = Vector2(110,y_value)

func hit_wall() -> void:
	print("Hit wall")
	pinned = true
	await get_tree().create_timer(pin_duration).timeout
	release_enemies()
	queue_free()

func release_enemies() -> void:
	var spacing:float = 0
	for enemy in captured_enemies:
		if not is_instance_valid(enemy):
			continue
		if flipped:
			spacing += 100
		else:
			spacing += -100
		# HACK
		var brain:EnemyBrainComponent = enemy.find_child("EnemyBrainComponent")
		#brain.transition_to_next_state("EnemyReturn")
		brain.enemy_hit(1.0, 1)
		var world_pos = enemy.global_position
		var safe_pos = TeleportFinder.find_valid_position(enemy, world_pos)
		remove_child(enemy)
		# Spear exists seperate from player
		get_tree().get_root().add_child(enemy)
		print(safe_pos)
		enemy.global_position = Vector2((safe_pos.x + spacing), safe_pos.y)
		
		#if enemy.has_method("set_captured"):
		#    enemy.set_captured(false)
	
	captured_enemies.clear()

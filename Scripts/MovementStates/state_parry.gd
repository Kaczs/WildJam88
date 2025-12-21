extends MovementState
var parry_area:Area2D

func enter(_previous_state_path: String, _data := {}):
	# Clear current attack combo
	parent.current_attack_combo.clear()
	# Flip hitbox depending on facing
	if sprite.flip_h == true:
		parent.flip_character()
	# Go find the parry area if we haven't yet (first time changing to this state)
	if parry_area == null:
		parry_area = owner.find_child("ParryArea")
	parry_area.connect("body_entered", check_bodies_for_parry)
	parry_area.connect("area_shape_entered", check_areas_for_parry)
	animation_player.play("parry")
	player_body.velocity.x = 0

func phys_update(_delta: float):
	# Gravity
	player_body.velocity.y += gravity * _delta
	# Start running based on player input
# Stuff we need to cancel into
	if parent.cannot_cancel == false:
		# Next attack in the chain
		if Input.is_action_just_pressed("Attack"):
			finished.emit("StateStandingAttack2")
		# Trying to jump?
		elif Input.is_action_pressed("Up") and player_body.is_on_floor():
			finished.emit("StateJumping")
		# Optionally immediately animation: X X X 
		# if hit
		# 0.16s after animation then unlock player > nother attack > jump > move > parry
		# kill 0.16s delay if hit a guy
# Can freely cancel anytime
	elif Input.is_action_just_pressed("special1") and impulsiveness_component.current_impulsiveness >= 33:
		finished.emit("StateRadiantDash")
	player_body.move_and_slide()

## Enemies are rigidbodies, so check for those and let them
## know they're being parried
func check_bodies_for_parry(body):
	print("body found for parry: " + body.name)
	var enemy_brain:EnemyBrainComponent = body.get_node_or_null("EnemyBrainComponent")
	if enemy_brain != null:
		enemy_brain.parry(2)

func check_areas_for_parry(_area_rid, area, _area_index, _local_shape_index):
	print("body found for parry: " + area.name)
	var projectile:Projectile = area.get_parent()
	if projectile != null:
		projectile.die()

func exit() -> void:
	# Dont want this state doing anything unless it's the active one
	parry_area.disconnect("body_entered", check_bodies_for_parry)
	parry_area.disconnect("area_shape_entered", check_areas_for_parry)
	player_body.velocity.x = 0

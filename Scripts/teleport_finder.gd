extends Node


## Takes a physBody2D and point, and tries to find a valid spot to teleport to
## step count determines the amount of steps back to try
static func find_valid_position(entity: PhysicsBody2D, target: Vector2, step_count: int = 10):
	var space_state = entity.get_world_2d().direct_space_state
	var collision_shape = entity.get_node("Hurtbox") # Should probably change incase collider isnt called hurtbox?

	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = collision_shape.shape
	# Which layer to look on
	query.collision_mask = entity.collision_mask
	# exclude this entity
	query.exclude = [entity.get_rid()]

	var origin = entity.global_position

	# Try to actually find a valid position
	for i in range(step_count):
		var attempt_target = float(i) / (step_count - 1)
		var test_pos = target.lerp(origin, attempt_target)

		query.transform = Transform2D(collision_shape.rotation, test_pos)

		if space_state.intersect_shape(query, 1).is_empty():
			return test_pos
	return origin
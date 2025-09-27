extends CharacterBody2D

const SPEED = 60.0
var direction = -1  # -1 for left, 1 for right

func _physics_process(delta):
	velocity.x = SPEED * direction
	move_and_slide()


	if is_on_wall() or is_at_edge():
		direction *= -1

func is_at_edge() -> bool:
	var raycast_pos = global_position + Vector2(direction * 10, 16)
	var space_state = get_world_2d().direct_space_state

	var ray_params = PhysicsRayQueryParameters2D.new()
	ray_params.from = raycast_pos
	ray_params.to = raycast_pos + Vector2(0, 10)
	ray_params.exclude = [self]

	var result = space_state.intersect_ray(ray_params)
	return result.empty()

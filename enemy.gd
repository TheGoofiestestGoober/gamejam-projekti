extends CharacterBody2D

const speed = 50

var direction = 1
var hasSwitchedDirection = false


func _ready():
	var ray_left = $RayCastLeft
	var ray_right = $RayCastRight
	var ray_down = $RayCastDown1
	var ray_down2 = $RayCastDown2

	# Example: enable all raycasts
	ray_left.enabled = true
	ray_right.enabled = true
	ray_down.enabled = true
	ray_down2.enabled = true
	
func startTimer():
	await get_tree().create_timer(0.3).timeout
	hasSwitchedDirection = false
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * speed
	

	if not hasSwitchedDirection:
		if $RayCastLeft.is_colliding():
			direction *= -1
			hasSwitchedDirection = true
			startTimer()
		if $RayCastRight.is_colliding():
			direction *= -1
			hasSwitchedDirection = true
			startTimer()
		if not $RayCastDown1.is_colliding():
			direction *= -1
			hasSwitchedDirection = true
			startTimer()
		if not $RayCastDown2.is_colliding():
			direction *= -1
			hasSwitchedDirection = true
			startTimer()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.


	move_and_slide()


func _on_killarea_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		queue_free()

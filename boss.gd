extends CharacterBody2D

const speed = 50


var startingOrientation = scale.x
var direction = 1
var hasSwitchedDirection = false
var bossHP = 3

func _ready():
	var ray_right = $RayCastRight
	var ray_down2 = $RayCastDown2

	# Example: enable all raycasts
	ray_right.enabled = true
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
		if $RayCastRight.is_colliding():
			direction *= -1
			scale.x *= -1
			hasSwitchedDirection = true
			startTimer()
		if not $RayCastDown2.is_colliding():
			direction *= -1
			scale.x *= -1
			hasSwitchedDirection = true
			startTimer()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.


	move_and_slide()


func _on_killarea_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		bossHP -= 1
		if position.x >= 0:
			position.x += 60
		else:
			position.x -= 60
		
		if bossHP == 0:
			queue_free()

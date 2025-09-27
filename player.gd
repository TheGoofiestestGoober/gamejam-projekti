extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0



var Sword_On_Cooldown = false

func _ready() -> void:
	$Sword.visible = false
	$Sword/Area2D/CollisionShape2D.disabled = true


	



func die():
	get_tree().reload_current_scene()
	
func attack():
	
	if not Sword_On_Cooldown:
		$Sword.visible = true
		$Sword/Area2D/CollisionShape2D.disabled = false

		await get_tree().create_timer(0.5).timeout

		$Sword.visible = false
		$Sword/Area2D/CollisionShape2D.disabled = true
		Sword_On_Cooldown = true
		async_hide_sword()
func async_hide_sword() -> void:
	await get_tree().create_timer(0.3).timeout
	$Sword.visible = false
	$Sword/Area2D/CollisionShape2D.disabled = true

	await get_tree().create_timer(0.3).timeout
	Sword_On_Cooldown = false
	

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if position.y >= 525:
			die()
	if Input.is_action_just_pressed("attack"):
		attack()	
			

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("hi")
	if not area.is_in_group("transfer") and not area.is_in_group("sword"):
		print("hi")
		die()

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0



var Sword_On_Cooldown = false
var facingDirection = 0
var lastFaced = 1

var KalleWalkingLeft = preload("res://assets/Kalle walking left.png")
var KalleWalkingRight = preload("res://assets/Kalle walking right.png")
var Kalle = preload("res://assets/Kalle_kavelija.png")

@onready var KalleAnim = $Sprite2D


func _ready() -> void:
	$Sword.visible = false
	$Sword/Area2D/CollisionShape2D.disabled = true


	



func die():
	get_tree().reload_current_scene()
	
func attack():
	var swordPos = $Sword.position
	
	if lastFaced == 1:
		$Sword.scale.x = 1
		swordPos = $ShankPositionRight.position
	else:
		$Sword.scale.x = -1
		swordPos = $ShankPositionLeft.position
	$Sword.position = swordPos
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
	
	var level = get_tree().current_scene
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if position.y >= 525:
			die()
	if Input.is_action_just_pressed("attack") and level.swordIsUsable:
		attack()	
			

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("reset"):
		die()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var left = -1
	var right = 1
		
	if Input.is_action_pressed("left") and level.canGoLeft:
		velocity.x = left * SPEED
		facingDirection = -1
		$AnimatedSprite2D.play("walk_left")
		lastFaced = -1
		
	elif Input.is_action_pressed("right") and level.canGoRight:
		velocity.x = right * SPEED
		facingDirection = 1
		$AnimatedSprite2D.play("walk_right")
		lastFaced = 1
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		facingDirection = 0
		$AnimatedSprite2D.play("default")
		

	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not area.is_in_group("transfer") and not area.is_in_group("sword"):
		die()

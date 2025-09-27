extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://level5.tscn")

		print("Player touched the collider!")
		# Handle player touch logic here

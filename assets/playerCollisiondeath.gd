extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _on_body_entered(body):
	print("hi")
	if body.name == "Enemy":
		die()

func die():
	get_tree().reload_current_scene()

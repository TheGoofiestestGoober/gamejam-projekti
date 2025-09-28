extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	var level = get_tree().current_scene
	if level.has_method("DisableGoingLeft"):
		level.DisableGoingLeft()
		visible = false


func _on_texture_button_2_pressed() -> void:
	var level = get_tree().current_scene
	if level.has_method("DisableGoingRight"):
		level.DisableGoingRight()
		visible = false

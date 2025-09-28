extends Node

var swordIsUsable := true
var canGoLeft := true
var canGoRight := true

func DisableSwordUsage():
	swordIsUsable = false
func DisableGoingLeft():
	canGoLeft = false
func DisableGoingRight():
	canGoRight = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sacrificeMenu = preload("res://FinalSacrificeMenu.tscn")
	var menuInstance = sacrificeMenu.instantiate()
	add_child(menuInstance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

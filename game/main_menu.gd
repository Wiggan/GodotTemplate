extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.state = GameManager.State.MainMenu
	GameManager.call_deferred("pause")

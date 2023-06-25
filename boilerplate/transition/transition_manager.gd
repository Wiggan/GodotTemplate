extends Control

@onready var menu_animation = $Menu/MenuAnimation
@onready var menu = $Menu


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("paused", menu_animation.play.bind("show"))
	GameManager.connect("unpaused", menu_animation.play.bind("hide"))


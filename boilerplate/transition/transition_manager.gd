extends Control

@onready var transition_animations = $Black/TransitionAnimations
@onready var menu_animation = $Menu/MenuAnimation
@onready var menu = $Menu
@onready var background_level_loader = preload("res://boilerplate/transition/background_level_loader.tscn")

var callback: Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("paused", menu_animation.play.bind("show"))
	GameManager.connect("unpaused", menu_animation.play.bind("hide"))

func load_level(level):
	var loader = background_level_loader.instantiate()
	loader.scene_to_load = level
	add_child(loader)

func fade_and_call(callable):
	callback = callable
	transition_animations.play("FadeToBlackAndCall")
	
func fade_in():
	transition_animations.play("FadeIn")
	

func call_callback():
	if callback:
		callback.call()

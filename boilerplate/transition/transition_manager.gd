extends Control

@onready var menu_animation = $Menu/MenuAnimation
@onready var menu = $Menu


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		if menu.visible:
			menu_animation.play("hide")
		else:
			menu_animation.play("show")
			
func hide_menu():
	if menu.visible:
		menu_animation.play("hide")
	

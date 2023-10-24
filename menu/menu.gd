extends Control

@onready var screens = $Screens
@onready var menu_items = $Screens/MenuItems

@onready var screen_buttons = [
	$Screens/MenuItems/HighScore, 
	$Screens/MenuItems/HowToPlay, 
	$Screens/MenuItems/Options, 
	$Screens/MenuItems/Credits
]

func _ready():
	#visibility_changed.connect(_on_visibility_changed)
	for button in screen_buttons:
		button.pressed.connect(show_screen.bind(button.name))
		

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if not menu_items.visible:
			show_screen("MenuItems")
			
			# Consume this event so that menu does not close on escape
			get_viewport().set_input_as_handled()


func _on_resume_pressed():
	if GameManager.state == GameManager.State.Game:
		create_tween().tween_callback(GameManager.unpause).set_delay(0.3)
	elif GameManager.has_saved_game():
		GameManager.restart(false)

func _on_start_pressed():
	GameManager.restart(true)

func _on_exit_pressed():
	Transition.fade_and_call(get_tree().quit)

func _on_back_button_pressed():
	show_screen("MenuItems")


const FADE_TIME = 0.4  # s
var screen_tween: Tween = null

func get_screen_tween():
	if screen_tween:
		screen_tween.kill()
	screen_tween = create_tween()
	return screen_tween

func show_screen(screen):
	var tween = get_screen_tween()
	for child in screens.get_children():
		if child.name == screen:
			tween.parallel().tween_property(child, "modulate", Color.WHITE, FADE_TIME)
			tween.parallel().tween_callback(child.show)
		else:
			tween.parallel().tween_property(child, "modulate", Color.TRANSPARENT, FADE_TIME)
			tween.parallel().tween_callback(child.hide).set_delay(FADE_TIME)

func show_menu():
	show_screen("MenuItems")

#func _on_visibility_changed():
#	if $"..".is_visible_in_tree():
#		if GameManager.state == GameManager.State.Game or GameManager.has_saved_game():
#			resume.disabled = false
#			resume.grab_focus()
#		else:
#			resume.disabled = true
#			start.grab_focus()
#
		

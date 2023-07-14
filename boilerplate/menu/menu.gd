extends VBoxContainer
@onready var options = $"../SubMenus/Options"
@onready var credits = $"../SubMenus/Credits"
@onready var how_to_play = $"../SubMenus/HowToPlay"
@onready var resume = $Resume

@onready var sub_menu_animator = $"../SubMenuAnimator"
@onready var sub_menus = $"../SubMenus"

func _on_show():
	resume.grab_focus()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if sub_menus.visible:
			sub_menu_animator.play("hide_submenu")
			
			# Consume this event so that menu does not close on escape
			get_viewport().set_input_as_handled()


func _on_resume_pressed():
	GameManager.unpause()


func _on_start_pressed():
	Transition.fade_and_call(Transition.load_level.bind("res://game/game.tscn"))

func _on_how_to_play_pressed():
	options.visible = false
	credits.visible = false
	how_to_play.visible = true
	sub_menu_animator.play("show_submenu")

func _on_options_pressed():
	options.visible = true
	credits.visible = false
	how_to_play.visible = false
	sub_menu_animator.play("show_submenu")


func _on_credits_pressed():
	options.visible = false
	credits.visible = true
	how_to_play.visible = false
	sub_menu_animator.play("show_submenu")


func _on_exit_pressed():
	Transition.fade_and_call(get_tree().quit)


func _on_back_button_pressed():
	sub_menu_animator.play("hide_submenu")

func _on_visibility_changed():
	if visible and resume:
		resume.grab_focus()

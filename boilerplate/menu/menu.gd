extends VBoxContainer
@onready var options = $"../SubMenus/Options"
@onready var sub_menu_animator = $"../SubMenuAnimator"
@onready var sub_menus = $"../SubMenus"


func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		if sub_menus.visible:
			sub_menu_animator.play("hide_submenu")
			
			# Consume this event so that menu does not close on escape
			get_viewport().set_input_as_handled()
			

func _on_resume_pressed():
	pass # Replace with function body.


func _on_start_pressed():
	pass # Replace with function body.


func _on_how_to_play_pressed():
	options.visible = false


func _on_options_pressed():
	options.visible = true
	sub_menu_animator.play("show_submenu")


func _on_credits_pressed():
	options.visible = false


func _on_exit_pressed():
	get_tree().quit()

extends GridContainer

func set_initial_values():
	$MouseSenitivitySlider.value = Config.sensitivity
	$ScreenShakeCheckBox.button_pressed = Config.screen_shake
	
# Set parameter values when config has been read from disk
func _init():
	Config.connect("ready", set_initial_values)

func _on_visibility_changed():
	if is_visible_in_tree():
		$MouseSenitivitySlider.grab_focus()

func _on_check_box_toggled(button_pressed):
	Config.set_config_parameter("screen_shake", button_pressed)

func _on_mouse_senitivity_slider_value_changed(value):
	Config.set_config_parameter("sensitivity", value)

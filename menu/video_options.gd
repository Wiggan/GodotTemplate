extends Control
@onready var fullscreen_check_box = $FullscreenCheckBox


func set_initial_values():
	$OptionButton.add_item("Original: 1.00")
	$OptionButton.add_item("Ultra Quality: 0.77")
	$OptionButton.add_item("Quality: 0.67")
	$OptionButton.add_item("Balanced: 0.59")
	$OptionButton.add_item("Performance: 0.5")
	$FullscreenCheckBox.button_pressed = Config.fullscreen
	$OptionButton.selected = Config.render_scale
	$BrightnessSlider.value = Config.brightness
	$SDFGICheckbox.button_pressed = Config.sdfgi
	
# Set parameter values when config has been read from disk
func _init():
	Config.connect("ready", set_initial_values)

func _on_scaling_slider_value_changed(value):
	RenderingServer.viewport_set_scaling_3d_scale(get_viewport().get_viewport_rid(), value)
	Config.set_config_parameter("render_scale", value)
	$ScalingContainer/ScaleLabel.text = str(value) + "x"

func _on_fullscreen_check_box_toggled(button_pressed):
	DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN if button_pressed else DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
	Config.set_config_parameter("fullscreen", button_pressed)

func _on_brightness_slider_value_changed(value):
	Config.set_config_parameter("brightness", value)

func _on_visibility_changed():
	if is_visible_in_tree():
		fullscreen_check_box.grab_focus()

const SCALES = [1.0, 0.77, 0.67, 0.59, 0.5]
func _on_option_button_item_selected(index):
	RenderingServer.viewport_set_scaling_3d_scale(get_viewport().get_viewport_rid(), SCALES[index])
	Config.set_config_parameter("render_scale", index)


func _on_sdfgi_checkbox_toggled(button_pressed):
	Config.set_config_parameter("sdfgi", button_pressed)

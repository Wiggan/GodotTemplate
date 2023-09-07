# Note: Only keyboard and mouse button input is supported at the moment

extends Control
@onready var reset_input_button = $MarginContainer/VBoxContainer/ResetInputButton
@onready var container = $MarginContainer/VBoxContainer


const control_widget = preload("res://menu/control_widget.tscn")

func set_initial_values():
	var controls = Config.get_controls()
	for action in controls:
		print(controls[action])
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, controls[action])

# Set parameter values when config has been read from disk
func _init():
	Config.connect("ready", set_initial_values)

func _ready():
	for action in InputMap.get_actions():
		if "ui_" not in action:
			var input = InputMap.action_get_events(action)[0].as_text()
			var control = control_widget.instantiate()
			control.call_deferred("initialize", action, input)
			container.add_child(control)


func _on_reset_input_button_pressed():
	InputMap.load_from_project_settings()
	Config.clear_controls()
	for child in container.get_children():
		if child.has_method("initialize"):
			var input = InputMap.action_get_events(child._action_name)[0].as_text()
			child.initialize(child._action_name, input)

func _on_visibility_changed():
	if is_visible_in_tree():
		reset_input_button.grab_focus()

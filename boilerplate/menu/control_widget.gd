extends Control

@onready var action_name_label = $HBoxContainer/ActionName
@onready var rebind = $HBoxContainer/Rebind
@onready var waiting_for_input = $WaitingForInput
@onready var h_box_container = $HBoxContainer

var _action_name

func _ready():
	set_process_input(false)

func initialize(action_name, input_name):
	_action_name = action_name
	action_name_label.text = action_name.capitalize()
	rebind.text = input_name

# JSON can't handle the various InputEvent types
func _input_to_json(input):
	var dict = {}
	if input is InputEventMouseButton:
		dict["type"] = "InputEventMouseButton"
		dict["button_index"] = input.button_index
		dict["pressed"] = input.pressed
	elif input is InputEventKey:
		dict["type"] = "InputEventKey"
		dict["keycode"] = input.keycode
		dict["pressed"] = input.pressed
		
	return JSON.stringify(dict)

func overload_action(input_event):
	print("Rebinding action " + _action_name + " to ", input_event)
	InputMap.action_erase_events(_action_name)
	InputMap.action_add_event(_action_name, input_event)
	rebind.text = input_event.as_text()
	Config.set_config_parameter(_action_name, _input_to_json(input_event), Config.CONTROL_SECTION)

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		if not event.is_action_pressed("ui_cancel"):
			overload_action(event)
		set_process_input(false)
		waiting_for_input.visible = false
		
		# Assigning space immediately opened the rebind panel again, but with deferred it does not.
		h_box_container.set_deferred("visible", true)
		rebind.call_deferred("grab_focus")
		
		# Consume this event so that menu does not close on escape
		get_viewport().set_input_as_handled()

func _on_rebind_pressed():
	set_process_input(true)
	waiting_for_input.visible = true
	h_box_container.visible = false
	

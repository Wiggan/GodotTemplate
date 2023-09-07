extends Node

var config_file = ConfigFile.new()
const FILE_NAME = "user://config.cfg"
const SECTION = "Config"
const CONTROL_SECTION = "Controls"

signal parameter_updated(parameter_name)

# audio parameters
var master_volume = 1
var bgm_volume = 0.14
var sfx_volume = 1

# video parameters
var render_scale = 1
var fullscreen = false
var brightness = 1
var sdfgi = true

# game parameters
var sensitivity = 5
var screen_shake = 1

var nickname = ""

# Load config file on ready
func _ready():
	var result = config_file.load(FILE_NAME)
	
	if result == OK:
		print("Loaded configuration from file")
	else:
		print("No configuration file found")
	
	load_config()

func _is_script_variable(property_name):
	for property in get_property_list():
		if property.name == property_name:
			return property.usage == 4096
	return false
	

# Override set so that both config file and properties are overwritten
func set_config_parameter(property, value, section=SECTION):
	config_file.set_value(section, property, value)
	config_file.save(FILE_NAME)
	set(property, value)
	parameter_updated.emit(property)

# JSON can't handle the various InputEvent types
func _json_to_input(json):
	var event
	if "InputEventKey" == json["type"]:
		event = InputEventKey.new()
		event.keycode = json["keycode"]
	elif "InputEventMouseButton" == json["type"]:
		event = InputEventMouseButton.new()
		event.button_index = json["button_index"]
	elif "InputEventJoypadButton" == json["type"]:
		event = InputEventJoypadButton.new()
		event.button_index = json["button_index"]
	elif "InputEventJoypadMotion" == json["type"]:
		event = InputEventJoypadMotion.new()
		event.axis = json["axis"]
		event.axis_value = json["axis_value"]
	return event
	
func get_controls():
	var controls = {}
	if CONTROL_SECTION in config_file.get_sections():
		for key in config_file.get_section_keys(CONTROL_SECTION):
			var json = JSON.parse_string(config_file.get_value(CONTROL_SECTION, key))
			if json:
				controls[key] = _json_to_input(json)
			else:
				print("Failed parsing " + key)
			
	return controls

func load_config():
	for property in get_property_list():
		if config_file.has_section_key(SECTION, property.name):
			set(property.name, config_file.get_value(SECTION, property.name, get(property.name)))

func clear_controls():
	if config_file.has_section(CONTROL_SECTION):
		config_file.erase_section(CONTROL_SECTION)
		config_file.save(FILE_NAME)
	

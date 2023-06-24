extends Control

func set_initial_values():
	$BGMVolumeSlider.value = Config.bgm_volume
	$SFXVolumeSlider.value = Config.sfx_volume
	$MasterVolumeSlider.value = Config.master_volume

# Set parameter values when config has been read from disk
func _init():
	Config.connect("ready", set_initial_values)

func _set_bus_volume(bus, config_parameter_name, linear_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db(linear_volume))
	Config.set_config_parameter(config_parameter_name, linear_volume)
	print("New volume in db: " + str(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus))))

func _on_bgm_volume_slider_value_changed(value):
	_set_bus_volume("BGM", "bgm_volume", value)

func _on_sfx_volume_slider_value_changed(value):
	_set_bus_volume("SFX", "sfx_volume", value)

func _on_master_volume_slider_value_changed(value):
	_set_bus_volume("Master", "master_volume", value)



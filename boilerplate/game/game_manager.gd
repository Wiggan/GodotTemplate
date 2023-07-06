extends Node

signal paused
signal unpaused
signal game_saved

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func _unhandled_input(event):
	if event.is_action_pressed("ui_menu"):
		if get_tree().paused:
			unpause()
		else:
			pause()
	elif event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			unpause()
			
func unpause():
	get_tree().paused = false
	unpaused.emit()
	
func pause():
	get_tree().paused = true
	paused.emit()
	
func game_over():
	get_tree().reload_current_scene()

func save_game():
	game_saved.emit()
	pass
	
func load_game():
	pass
	
func has_saved_game():
	return false

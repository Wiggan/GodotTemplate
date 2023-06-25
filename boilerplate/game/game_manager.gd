extends Node

signal paused
signal unpaused

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			unpause()
		else:
			pause()
			
func unpause():
	get_tree().paused = false
	unpaused.emit()
	
func pause():
	get_tree().paused = true
	paused.emit()

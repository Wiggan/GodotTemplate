extends Control

signal paused
signal unpaused
signal game_saved

@onready var game_over_screen = $GameOverScreen


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
	get_tree().paused = true
	Cursor.show_cursor()
	Transition.fade_and_call(show_game_over_screen)

func show_game_over_screen():
	game_over_screen.set_visible(true)
	$GameOverScreen/VBoxContainer/RetryButton.grab_focus()

func restart():
	game_over_screen.set_visible(false)
	get_tree().reload_current_scene()
	Transition.fade_in()
	Cursor.hide_cursor()
	get_tree().paused = false

## TODO implement these depending on game
func save_game():
	game_saved.emit()
	pass
	
func load_game():
	pass
	
func has_saved_game():
	return false

extends TabContainer


func _unhandled_input(event):
	if event.is_action_pressed("ui_previous_tab"):
		current_tab = (get_tab_count() + current_tab-1) % get_tab_count()
	elif event.is_action_pressed("ui_next_tab"):
		current_tab = (current_tab+1) % get_tab_count()
		

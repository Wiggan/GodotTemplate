extends Node
@onready var button_hover = $ButtonHover
@onready var button_click = $ButtonClick


# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons: Array = get_tree().get_nodes_in_group("Button")
	var sliders: Array = get_tree().get_nodes_in_group("Slider")
	var tab_containers: Array = get_tree().get_nodes_in_group("TabContainer")
	for inst in buttons:
		inst.connect("pressed", on_button_pressed)
		inst.connect("toggled", on_button_toggled)
		inst.connect("mouse_entered", on_focus_entered)
		inst.connect("focus_entered", on_focus_entered)
	
	for inst in sliders:
		inst.connect("drag_started", on_button_pressed)
		inst.connect("mouse_entered", on_focus_entered)
		inst.connect("focus_entered", on_focus_entered)
		
	for inst in tab_containers:
		inst.connect("tab_changed", on_tab_clicked)
		inst.connect("tab_hovered", on_tab_hovered)
		
func on_tab_clicked(_tab):
	button_click.play()
	
func on_tab_hovered(_tab):
	button_hover.play()
	
func on_button_pressed()->void:
	button_click.play()
	
func on_button_toggled(_pressed)->void:
	button_click.play()
	
func on_focus_entered()->void:
	button_hover.play()

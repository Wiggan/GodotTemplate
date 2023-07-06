extends Node
@onready var button_hover = $"../ButtonHover"
@onready var button_click = $"../ButtonClick"


# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons: Array = get_tree().get_nodes_in_group("Button")
	var sliders: Array = get_tree().get_nodes_in_group("Slider")
	for inst in buttons:
		inst.connect("pressed", on_button_pressed)
		inst.connect("toggled", on_button_toggled)
		inst.connect("mouse_entered", on_focus_entered)
	
	for inst in sliders:
		inst.connect("drag_started", on_button_pressed)
		inst.connect("mouse_entered", on_focus_entered)
	
func on_button_pressed()->void:
	button_click.play()
	
func on_button_toggled(_pressed)->void:
	button_click.play()
	
func on_focus_entered()->void:
	button_hover.play()

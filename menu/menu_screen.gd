class_name BaseMenuScreen
extends PanelContainer
@onready var back_button = $MarginContainer/BackButton

signal back

# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.pressed.connect(emit_signal.bind("back"))

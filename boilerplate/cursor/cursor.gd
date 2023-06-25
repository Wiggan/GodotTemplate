extends CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("paused", show_cursor)
	GameManager.connect("unpaused", hide_cursor)
	hide_cursor()
	
func show_cursor():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	emitting = true
	set_process_input(true)
	
	
func hide_cursor():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	emitting = false
	set_process_input(false)
	

func _input(event):
	if event is InputEventMouseMotion:
		transform.origin = get_viewport().get_mouse_position() + Vector2(10, 10)

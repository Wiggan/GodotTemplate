@tool
class_name Navigator
extends NavigationAgent3D

@export var movement_speed = 2.0
@export var character_body: CharacterBody3D


func _physics_process(_delta):
	if not character_body:
		return
	if is_navigation_finished():
		return

	var next_path_position: Vector3 = get_next_path_position()
	var current_agent_position: Vector3 = character_body.global_position
	var new_velocity: Vector3 = (next_path_position - current_agent_position).normalized() * movement_speed
	if avoidance_enabled:
		set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	if not character_body:
		return
	character_body.velocity = safe_velocity
	character_body.move_and_slide()


func _get_configuration_warnings():
	if not character_body:
		return ["You must connect a CharacterBody3D for the navigator to work"]
	else:
		return []

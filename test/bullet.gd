extends Node3D

const SPEED = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position += delta * basis.z * SPEED


func _on_timer_timeout():
	queue_free()

extends Node3D
@onready var animation_player = $AnimationPlayer

const SPEED = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position += delta * basis.z * SPEED


func _on_timer_timeout():
	animation_player.play("explode")


func _on_area_3d_body_entered(body):
	animation_player.play("explode")
	if not body.collision_layer & 1:
		body.on_hit()
	animation_player.play("explode")

extends CharacterBody3D

@export var hp = 3
@export var max_hp = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()

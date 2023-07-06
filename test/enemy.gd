extends RigidBody3D

@onready var navigation_agent_3d = $NavigationAgent3D
@onready var animation_player = $AnimationPlayer

var speed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation_agent_3d.target_position = Vector3(0, 1, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var direction = (navigation_agent_3d.get_next_path_position() - global_position).normalized()
	navigation_agent_3d.set_velocity(direction*speed)

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	linear_velocity = safe_velocity

func on_hit():
	animation_player.play("die")

extends CharacterBody3D

const HALF_PI = PI/2

@export_category("Camera")
@export_range(1, 10, 0.1) var mouse_sensitivity: float = 5
@export_range(0, 90, 0.1) var max_vertical_rotation: float = 70

@export_category("Movement")
@export var speed: float = 5.0
@export var jump_velocity: float = 4.5

@onready var gun = $Head/Gun
@onready var camera = $Head/Camera 
@onready var hitscan_container = $Head/Camera/HitscanContainer 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	gun.use(hitscan_container)
	

func _input(event):
	if event is InputEventMouseMotion:
		move_camera(event)

func move_camera(event: InputEventMouseMotion):
	rotate_y(-event.relative.x * mouse_sensitivity * 0.0005)
	$Head.rotate_x(-event.relative.y * mouse_sensitivity * 0.0005)
	var angle = deg_to_rad(max_vertical_rotation)
	$Head.rotation.x = clamp($Head.rotation.x, -angle, angle)


func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

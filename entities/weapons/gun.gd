extends Node3D

@export var spread = 4

@onready var hitscan: RayCast3D = $Hitscan
@onready var bullet_decal = preload("res://entities/weapons/bullet_decal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# when this function is called, align the hitscan to the camera
func use(hitscan_container: Node3D):
	hitscan.reparent(hitscan_container, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		process_shoot()
	
		
func process_shoot():
	hitscan.target_position.x = randf_range(spread, -spread)
	hitscan.target_position.y = randf_range(spread, -spread)
	if not hitscan.is_colliding():
		return
	var collider = hitscan.get_collider()
	impact_hole()
	if collider.is_in_group("Enemy"):
		collider.take_damage(1)

func impact_hole():
	var bd = bullet_decal.instantiate()
	hitscan.get_collider().add_child(bd)
	bd.global_transform.origin = hitscan.get_collision_point()
	if abs(hitscan.get_collision_normal()) == Vector3.UP:
		bd.rotate_x(PI/2 * hitscan.get_collision_normal().y)
	else:
		bd.look_at(hitscan.get_collision_point() + hitscan.get_collision_normal(), Vector3.UP)
	

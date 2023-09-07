extends ShapeCast3D

@export var damage = 20
@export var instigator: CharacterBody3D
@export var status_effects: Array[Enums.StatusEffect]

signal hit_environment(point, normal)
signal hit_enemy

var hit_objects = []
var previous_position = Vector3.ZERO
@export var shape_casting = false:
	set(value):
		shape_casting = value
		if value:
			hit_objects = []
			previous_position = global_position
			

func _physics_process(_delta):
	if shape_casting:
		target_position = to_local(previous_position)
		force_shapecast_update()
		
		if is_colliding():
			for i in range(get_collision_count()):
				var collider = get_collider(i)
				var collision_point = get_collision_point(i)
				if collider not in hit_objects:
					if collider.collision_layer & 1:
						hit_environment.emit(collision_point, get_collision_normal(i))
					else:
						if collider.has_method("take_damage"):
							hit_objects.append(collider)
							collider.take_damage(damage, status_effects, global_position, instigator)
							print(instigator.name + " inflicted " + str(damage) + " damage")
							hit_enemy.emit()
		
		previous_position = global_position

extends Node3D
@onready var timer = $Timer
const ENEMY = preload("res://test/enemy.tscn")
var min_time = randf_range(5, 10)
var max_time = min_time + randf_range(5, 10)
var enemies_spawned = 0
const speed_factor = 0.7
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(randf_range(min_time, max_time))


func _on_timer_timeout():
	timer.start(randf_range(min_time, max_time))
	var enemy = ENEMY.instantiate()
	enemy.speed += enemies_spawned * speed_factor
	add_sibling(enemy)
	enemy.set_deferred("global_position", global_position)
	enemies_spawned += 1

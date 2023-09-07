extends Node

const BATCH_SIZE = 10

var instancesToFree = []

# Called when the node enters the scene tree for the first time.
func add(instance):
	instancesToFree.append(instance)

func _process(_delta):
	var instancesProcessed = 0
	while instancesProcessed < BATCH_SIZE and instancesToFree.size() > 0:
		var instance = instancesToFree.pop_back()
		instance.queue_free()
		instancesProcessed += 1

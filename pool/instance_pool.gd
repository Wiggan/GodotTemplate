extends Node3D


func add(instance):
	add_child(instance)
	

func empty(blocked = false):
	print(get_child_count())
	for instance in get_children():
		if blocked:
			instance.queue_free()
		else:
			SmartQueuefree.add(instance)
	print(get_child_count())

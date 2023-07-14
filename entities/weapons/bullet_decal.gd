extends Node3D


func _on_timer_timeout():
	print('queue')
	SmartQueuefree.add(self)

extends Node

@export var slowdown_curve: Curve
@export var duration: float = 0.3
const FREQUENCY = 20

# This tween might need to be globally unique
var slowdown_tween
func play():
	var count = roundi(duration*FREQUENCY)
	var interval = 1.0/FREQUENCY
	if slowdown_tween:
		slowdown_tween.kill()
	slowdown_tween = create_tween()
	for i in range(count):
		slowdown_tween.tween_property(Engine, "time_scale", slowdown_curve.sample(float(i)/count), interval)
	slowdown_tween.tween_property(Engine, "time_scale", 1, interval)
	

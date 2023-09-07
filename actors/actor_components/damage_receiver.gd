@tool
extends Area3D
class_name DamageReceiver

@export var health: Health:
	set(value):
		health = value
		update_configuration_warnings()

func _get_configuration_warnings():
	if not health:
		return ["You must connect a health component for the damage receiver to work"]
	else:
		return []

func take_damage(amount: float, status_effects: Array[Enums.StatusEffect], from: Vector3, instigator):
	if health:
		health.take_damage(amount, status_effects, from, instigator)

class_name Health
extends Node

signal died
signal max_health_changed(new_max_health)
signal damage_taken(new_health)
signal healed(new_health)
signal stunned
signal slowed

var immune = false

@export var max_health: float = 100:
	set(value):
		max_health = value
		health = max_health
		max_health_changed.emit(value)
		
@onready var health: float = max_health:
	set(value):
		if value < health:
			damage_taken.emit(value)
		elif value > health:
			healed.emit(value)
		health = value
	
	
@export var immunities: Array[Enums.StatusEffect]
var alive = true

func _ready():
	max_health_changed.emit(max_health)

func heal(amount):
	if alive:
		health = clamp(health + amount, 0, max_health)

func take_damage(amount: float, status_effects: Array[Enums.StatusEffect], _from: Vector3, _instigator):
	print("taking damage: ", amount)
	if not alive:
		return
	amount = _pre_damage(amount)
	amount = _modify_damage(amount)
	health = _apply_damage(amount)
	
	if health == 0:
		if _instigator and _instigator.has_method("on_enemy_killed"):
			_instigator.on_enemy_killed()
		_die()
		return
	
	status_effects = _modify_status_effects(status_effects)
	_apply_status_effects(status_effects)

## Apply modifiers such as ethereal, invulnerable etc
func _pre_damage(amount):
	return amount

## Apply armor etc
func _modify_damage(amount):
	return amount

## Apply immortality etc
func _apply_damage(amount):
	if immune:
		return health
	return clamp(health - amount, 0, max_health)

func _die():
	alive = false
	died.emit()

## Negate status modifiers
func _modify_status_effects(status_effects):
	for status_effect in status_effects:
		if status_effect in immunities:
			status_effects.erase(status_effect)
	return status_effects

@onready var status_effect_callbacks = {
	Enums.StatusEffect.Stun: _on_stun,
	Enums.StatusEffect.Slow: _on_slow,
}

## Get stunned etc
func _apply_status_effects(status_effects):
	for status_effect in status_effects:
		status_effect_callbacks[status_effect].call()

func _on_stun():
	print("Stunned!")
	emit_signal("stunned")


func _on_slow():
	print("Slowed!")
	emit_signal("slowed")

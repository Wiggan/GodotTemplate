class_name Mana
extends Node

signal max_mana_changed(new_max_mana)
signal mana_used(new_mana)
signal mana_gained(new_mana)

@export var max_mana: float = 100:
	set(value):
		max_mana = value
		mana = max_mana
		max_mana_changed.emit(value)
		
@onready var mana = max_mana:
	set(value):
		if value < mana:
			mana_used.emit(value)
		elif value > mana:
			mana_gained.emit(value)
		mana = value
	

func _ready():
	max_mana_changed.emit(max_mana)

func gain_mana(amount):
	mana = clamp(mana + amount, 0, max_mana)

func use_mana(amount: float):
	amount = _modify_usage(amount)
	mana = _use_mana(amount)


## Apply mana cost reduction etc
func _modify_usage(amount):
	return amount

## Apply free mana combo?
func _use_mana(amount):
	return clamp(mana - amount, 0, max_mana)


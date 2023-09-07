@tool
class_name DamageGiver
extends Area3D

@export var amount: float = 20
@export var status_effects: Array[Enums.StatusEffect]
@export var character_body: CharacterBody3D

# This is a one shot timer
@onready var cooldown_timer: Timer = $CooldownTimer
var damage_active: bool = false

func _ready():
	body_entered.connect(on_body_entered)
	cooldown_timer.one_shot = true
	cooldown_timer.wait_time = 0.1


func _get_configuration_warnings():
	if not character_body:
		return ["You must connect a CharacterBody3D for the damage giver to work"]
	else:
		return []

func on_body_entered(body: Node3D):
	if cooldown_timer.time_left > 0:
		# Still cooling down
		print("Still cooling down")
		return
	
	if !damage_active:
		# Damage giver needs to be activated (while swinging, etc)
		print("Damage not enabled")
		return
	
	if body.has_node("Health"):
		var health_component: Health = body.get_node("Health")

		health_component.take_damage(amount, status_effects, global_position, character_body)
		cooldown_timer.start()
	else:
		print("Could not find health")

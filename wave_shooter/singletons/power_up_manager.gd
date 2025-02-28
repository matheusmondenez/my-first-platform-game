extends Node

signal powered_up

var power_ups: Array[Dictionary] = [
	{
		"scene": preload("res://wave_shooter/entities/power_ups/shield.tscn"),
		"resource": preload("res://wave_shooter/resoures/power_ups/shield_power_up.tres"),
	},
	{
		"scene": preload("res://wave_shooter/entities/power_ups/speed_shot.tscn"),
		"resource": preload("res://wave_shooter/resoures/power_ups/speed_shot_power_up.tres"),
	},
	{
		"scene": preload("res://wave_shooter/entities/power_ups/rotating_bit.tscn"),
		"resource": preload("res://wave_shooter/resoures/power_ups/orbital_bit_power_up.tres"),
	},
]
var active: Array = []

func activate(power_up: PackedScene, duration: float):
	active.append(power_up)
	emit_signal('powered_up')
	Global.player.add_child(power_up.instantiate())
	await get_tree().create_timer(duration).timeout
	active.erase(power_up)

func get_random() -> Dictionary:
	return power_ups.pick_random()

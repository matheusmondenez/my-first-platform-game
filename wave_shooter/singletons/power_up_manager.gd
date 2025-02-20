extends Node

signal powered_up

var power_ups: Array[PackedScene] = [
	preload("res://wave_shooter/entities/power_ups/shield.tscn"),
]
var active: Array = []

func activate(power_up: Node2D, duration: float):
	print('activate')
	active.append(power_up)
	emit_signal('powered_up')
	Global.player.add_child(power_up)
	await get_tree().create_timer(duration).timeout
	active.erase(power_up)

func get_random() -> PackedScene:
	return power_ups.pick_random()

extends Node

var power_ups: Array[PackedScene] = [
	preload("res://wave_shooter/entities/power_ups/shield.tscn"),
]
var active = null

func activate(power_up: Node2D, duration: float):
	active = power_up
	Global.player.add_child(power_up)
	get_tree().create_timer(duration).timeout.connect(func(): active = null)

func get_random() -> PackedScene:
	return power_ups.pick_random()

extends Node

var skills: Array[PackedScene]:
	get:
		return [
			preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
			preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
			preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
			preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
			preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
		]
var available: Array[PackedScene] = skills
var assigned: Array[PackedScene] = []

func assign(skill: PackedScene, key: int) -> void:
	#assigned.append(skill)
	assigned.insert(key, skill)
	available.erase(skill)

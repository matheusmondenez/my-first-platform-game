extends Node

var skills: Array[PackedScene]:
	get:
		return [
			preload("res://wave_shooter/entities/player/sweep_shot.tscn")
		]
var available: Array[PackedScene] = skills
var assigned: Array[PackedScene] = []

func assign(skill: PackedScene) -> void:
	assigned.append(skill)
	available.erase(skill)

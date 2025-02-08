extends Node

var all_skills: Array[PackedScene]:
	get:
		return [
			preload("res://wave_shooter/entities/player/sweep_shot.tscn")
		]

var assigned_skills: Array[PackedScene]:
	set(skill):
		available_skills.erase(skill)
		assigned_skills.append(skill)

var available_skills: Array[PackedScene]

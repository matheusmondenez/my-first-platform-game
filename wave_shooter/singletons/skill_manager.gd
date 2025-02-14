extends Node

signal skill_assigned(key: int, skill: PackedScene)

var skills: Array[PackedScene] = [
	preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
	preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
	preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
	preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
	preload("res://wave_shooter/entities/player/sweep_shot.tscn"),
]
var available: Array[PackedScene] = skills
var assigned: Array[PackedScene] = [null, null, null, null]

func assign(skill: PackedScene, key: int) -> void:
	emit_signal("skill_assigned", key, skill)
	if assigned.has(null):
		assigned.erase(null)
		assigned.insert(key, skill)
		available.erase(skill)

func get_random(quantity: int = 3) -> Array:
	var randoms: Array = []
	var loops: int = 0
	while loops < quantity:
		var random: PackedScene = available.pick_random()
		if not randoms.has(random):
			randoms.append(random)
			loops += 1
	return randoms

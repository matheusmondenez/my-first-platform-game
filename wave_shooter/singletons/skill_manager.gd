extends Node

#signal skill_assigned(key: int, skill: PackedScene)

var skills: Array[Dictionary] = [
	{
		"scene": preload("res://wave_shooter/entities/skills/sweep_shot.tscn"),
		"resource": preload("res://wave_shooter/resoures/skills/sweep_shot_skill.tres"),
	},
	{
		"scene": preload("res://wave_shooter/entities/skills/beam_shot.tscn"),
		"resource": preload("res://wave_shooter/resoures/skills/beam_shot_skill.tres"),
	},
	{
		"scene": preload("res://wave_shooter/entities/skills/laser_beam.tscn"),
		"resource": preload("res://wave_shooter/resoures/skills/laser_beam_skill.tres"),
	},
]
var available: Array[Dictionary] = skills
var assigned: Array[Dictionary] = [{}, {}, {}, {}]

func assign(skill: Dictionary, key: int) -> void:
	#emit_signal("skill_assigned", key, skill)
	if assigned[key].is_empty():
		assigned.pop_at(key)
		assigned.insert(key, skill)
		available.erase(skill)

func get_random(quantity: int = 3) -> Array[Dictionary]:
	if available.size() < quantity:
		quantity = available.size()
	var randoms: Array[Dictionary] = []
	var loops: int = 0
	while loops < quantity:
		var random: Dictionary = available.pick_random()
		if not randoms.has(random):
			randoms.append(random)
			loops += 1
	return randoms

func clear_all_cooldowns() -> void:
	for skill in assigned:
		if not skill.is_empty():
			skill["resource"].is_cooling = false

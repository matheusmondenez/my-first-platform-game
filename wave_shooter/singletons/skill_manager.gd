extends Node

signal skill_assigned(key: int, skill: Dictionary)

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
var passives: Array[Dictionary] = [
	{
		"scene": preload("res://wave_shooter/entities/power_ups/pixel_orb.tscn"),
		"resource": preload("res://wave_shooter/resoures/skills/passives/pixel_orb_skill.tres"),
	},
	{
		"scene": preload("res://wave_shooter/entities/power_ups/slash.tscn"),
		"resource": preload("res://wave_shooter/resoures/skills/passives/slash_skill.tres"),
	},
	{
		"scene": preload("res://wave_shooter/entities/power_ups/rotating_bit.tscn"),
		"resource": preload("res://wave_shooter/resoures/skills/passives/rotating_bit_skill.tres"),
	},
	{
		"scene": preload("res://wave_shooter/entities/power_ups/pixel_pulse.tscn"),
		"resource": preload("res://wave_shooter/resoures/skills/passives/pixel_pulse_skill.tres"),
	},
]
var available: Array[Dictionary] = skills
var available_passives: Array[Dictionary] = passives
var assigned: Array[Dictionary] = [{}, {}, {}, {}]
var applied_passives: Array[Dictionary]

func assign(skill: Dictionary, key: int) -> void:
	emit_signal("skill_assigned", key, skill)
	if assigned[key].is_empty():
		assigned.pop_at(key)
		assigned.insert(key, skill)
		available.erase(skill)

func apply(passive: Dictionary) -> void:
	applied_passives.append(passive)
	available_passives.erase(passive)

func get_random(quantity: int = 2) -> Array[Dictionary]:
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

func get_random_passives(quantity: int = 2) -> Array[Dictionary]:
	if available_passives.size() < quantity:
		quantity = available_passives.size()
	var randoms: Array[Dictionary] = []
	var loops: int = 0
	while loops < quantity:
		var random: Dictionary = available_passives.pick_random()
		if not randoms.has(random):
			randoms.append(random)
			loops += 1
	return randoms

func clear_all_cooldowns() -> void:
	for skill in assigned:
		if not skill.is_empty():
			skill["resource"].is_cooling = false

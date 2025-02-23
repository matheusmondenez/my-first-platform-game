extends Node

enum LANGUAGES { PT, EN }

const VERSION: String = "0.0.2"
const WAVES: Dictionary = {
	1: {
		"enemies_to_spawn": 10,
		"enemies": [
			preload("res://wave_shooter/entities/enemies/default/default_enemy.tscn"),
			preload("res://wave_shooter/entities/enemies/speedy/speedy_enemy.tscn"),
			preload("res://wave_shooter/entities/enemies/tank/tank_enemy.tscn"),
		],
		"power_ups_to_spawn": 1,
		"power_ups": [
			preload("res://wave_shooter/resoures/power_ups/shield_power_up.tres"),
		],
	},
	2: {},
	3: {},
	4: {},
	5: {},
	6: {},
	7: {},
	8: {},
	9: {},
	10: {},
}
const SKILLS: Array = [
	preload("res://wave_shooter/resoures/skills/sweep_shot_skill.tres"),
	preload("res://wave_shooter/resoures/skills/sweep_shot_skill.tres"),
	preload("res://wave_shooter/resoures/skills/sweep_shot_skill.tres"),
]

var game_configs: Dictionary = {
	"auto_shot": false,
	"camera_shake": true,
	"fullscreen": true,
	"language": LANGUAGES.EN,
}

var assigned_skills: Dictionary = {
	1: null,
	2: null,
	3: null,
	4: null,
}

extends Node

const VERSION: String = "0.0.2"

const WAVES: Dictionary = {
	1: {
		"enemies_to_spawn": 10,
		"enemies": [
			preload("res://wave_shooter/entities/enemies/default/enemy.tscn"),
			preload("res://wave_shooter/entities/enemies/speedy/speedy_enemy.tscn")
		],
		"power_ups_to_spawn": 1,
		"power_ups": [
			{
				"title": "shield",
				"scene": preload("res://wave_shooter/entities/power_up.tscn"),
				"icon": preload("res://wave_shooter/ui/cooldown_icon.tscn")
			}
		]
	},
	2: {},
	3: {},
	4: {},
	5: {},
	6: {},
	7: {},
	8: {},
	9: {},
	"boss": ""
}

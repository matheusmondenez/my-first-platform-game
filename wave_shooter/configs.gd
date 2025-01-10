extends Node

const VERSION: String = "0.0.1"

const WAVES: Dictionary = {
	1: {
		"enemies_to_spawn": 10,
		"enemies": [
			preload("res://wave_shooter/actors/enemy.tscn"),
			preload("res://wave_shooter/actors/speedy_enemy.tscn")
		],
		"power_ups_to_spawn": 1,
		"power_ups": [
			preload("res://wave_shooter/actors/power_up.tscn")
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

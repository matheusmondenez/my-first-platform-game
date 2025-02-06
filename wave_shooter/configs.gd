extends Node

const VERSION: String = "0.0.2"

enum LANGUAGES {
	PT,
	EN,
}

var game_configs: Dictionary = {
	"auto_shot": false,
	"camera_shake": true,
	"fullscreen": true,
	"language": LANGUAGES.EN,
}

const WAVES: Dictionary = {
	1: {
		"enemies_to_spawn": 10,
		"enemies": [
			preload("res://wave_shooter/entities/enemies/default/default_enemy.tscn"),
			preload("res://wave_shooter/entities/enemies/speedy/speedy_enemy.tscn")
		],
		"power_ups_to_spawn": 1,
		"power_ups": [
			preload("res://wave_shooter/resoures/power_ups/shield_power_up.tres")
			#{
				#"title": "shield",
				#"scene": preload("res://wave_shooter/entities/power_up.tscn"),
				#"icon": preload("res://wave_shooter/assets/icons/star.png")
			#},
			#{
				#"title": "triple_shot",
				#"scene": preload("res://wave_shooter/entities/power_up.tscn"),
				#"icon": preload("res://wave_shooter/assets/icons/arrow.png")
			#}
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
	10: {}
}

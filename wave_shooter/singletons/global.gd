extends Node

var parent_node_creation: Node = null
var camera: Node = null
var player: Node = null
var level: int = 1
var xp: int = 0
var points: int = 0
var high_score: int = 0
var current_wave: int = 1
var enemies_count: int = 0

const LEVELS = {
	1: {
		"max_xp": 19,
	},
	2: {
		"max_xp": 29,
	},
	3: {
		"max_xp": 39,
	},
	4: {
		"max_xp": 49,
	},
	5: {
		"max_xp": 59,
	},
}

func instance_node(node, location, parent, resource = null):
	var node_instance = node.instantiate()
	if resource:
		node_instance.props = resource
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func slow_time(time_scale: float, duration: float) -> void:
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration, true, false, true).timeout # Não precisa mais fazer duration * time_scale pra ignorar o time scale, o quarto parâmetro faz isso
	Engine.time_scale = 1

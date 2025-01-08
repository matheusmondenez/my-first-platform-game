extends Node

var parent_node_creation = null
var camera = null
var player = null
var points: int = 0
var high_score: int = 0
var current_wave: int = 1
var enemies_count: int = 0

func instance_node(node, location, parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

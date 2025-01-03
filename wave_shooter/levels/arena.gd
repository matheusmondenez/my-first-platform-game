extends Node2D

func _ready() -> void:
	Global.parent_node_creation = self

func _exit_tree() -> void:
	Global.parent_node_creation = null

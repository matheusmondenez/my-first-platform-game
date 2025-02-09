extends Node

func instantiate_and_add(scene: PackedScene, parent, location: Vector2 ) -> Node2D:
	var instance = scene.instantiate()
	parent.add_child(instance)
	instance.global_position = location
	return instance

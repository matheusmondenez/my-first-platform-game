extends Node

func instantiate_and_add(scene: PackedScene, parent, location: Vector2 ) -> Node2D:
	var instance = scene.instantiate()
	parent.add_child(instance)
	instance.global_position = location
	return instance

func get_scene_resource_props(scene: PackedScene):
	var instance: Object = scene.instantiate()
	var props: Resource = instance.props
	instance.free()
	return props

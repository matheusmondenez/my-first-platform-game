extends RayCast2D

@export var props: BaseSkill

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	await get_tree().create_timer(0.5).timeout
	queue_free()

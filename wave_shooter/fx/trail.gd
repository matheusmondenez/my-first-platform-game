extends Line2D

@export var length: int = 50
var speed: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	global_position = Vector2.ZERO
	global_rotation = 0
	speed = get_parent().global_position
	add_point(speed)
	while get_point_count() > length:
		remove_point(0)

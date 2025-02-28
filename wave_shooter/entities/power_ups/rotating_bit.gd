extends Polygon2D

@export var speed: int = 100

func _process(delta: float) -> void:
	var rotation = rotation_degrees + speed * delta
	rotation_degrees = fmod(rotation, 360)

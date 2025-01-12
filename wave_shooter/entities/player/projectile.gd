extends Polygon2D

var move: Vector2 = Vector2(1, 0)
var speed: int = 250
var unique_direction: bool = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if unique_direction:
		look_at(get_global_mouse_position())
		unique_direction = false
	global_position += move.rotated(rotation) * speed * delta

func _on_shoot_screen_exited() -> void:
	queue_free()

extends Polygon2D

var move: Vector2 = Vector2(1, 0)
var speed: int = 500
var unique_direction: bool = true
var angle: int = 0
var power: int = 1
var pierce: bool = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if unique_direction:
		look_at(get_global_mouse_position())
		unique_direction = false
	global_position += move.rotated(rotation - angle) * speed * delta

func _on_pierce_shot_screen_exited() -> void:
	print("SAIU DA TELA")
	queue_free()

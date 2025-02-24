extends Polygon2D

var move: Vector2 = Vector2(1, 0)
var speed: int = 500
var unique_direction: bool = true
var angle: int = 0
var power: int = 1
var origin: String = "Player"
var target: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO
var pierce: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if unique_direction:
		if get_parent().name == "Arena":
			look_at(get_global_mouse_position())
		else:
			look_at(target)
		unique_direction = false
	global_position += move.rotated(rotation - angle) * speed * delta

func _on_shoot_screen_exited() -> void:
	queue_free()

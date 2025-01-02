extends Polygon2D

var stats: BaseStats
var speed: int = 500
var move: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	move.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	global_position += speed * move * delta

extends Sprite2D

var speed: int = 0

func _process(delta: float) -> void:
	var direction = global_position.direction_to(Global.player.global_position)
	global_position += direction * speed

func _on_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.xp += 1
		collect()

func pull() -> void:
	speed = 10

func collect() -> void:
	queue_free()

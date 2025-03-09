extends Sprite2D

var speed: int = 0

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#Global.xp += stats.given_xp
		speed = 10
		Global.xp += 1
		await get_tree().create_timer(1).timeout
		queue_free()

func _process(delta: float) -> void:
	var direction = global_position.direction_to(Global.player.global_position)
	global_position += direction * speed

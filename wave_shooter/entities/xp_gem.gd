extends Sprite2D

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#Global.xp += stats.given_xp
		Global.xp += 1
		queue_free()

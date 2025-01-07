extends Polygon2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.player.powered_up.append("green")
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

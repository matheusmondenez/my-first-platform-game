extends Polygon2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		print("INIMIGO NO ESCUDO")

func _on_timer_timeout() -> void:
	queue_free()

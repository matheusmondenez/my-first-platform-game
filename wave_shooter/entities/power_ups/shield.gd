extends Polygon2D

func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2(1.3, 1.3), 0.07).from(Vector2(0.5, 0.5))
	tween.tween_property(self, "scale", Vector2(1, 1), 0.04)

func apply() -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		print("INIMIGO NO ESCUDO")

func _on_timer_timeout() -> void:
	Global.player.power_ups.erase("shield")
	queue_free()

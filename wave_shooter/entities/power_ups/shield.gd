extends Polygon2D

@export var props: BasePowerUp

func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2(1.3, 1.3), 0.07).from(Vector2(0.5, 0.5))
	tween.tween_property(self, "scale", Vector2(1, 1), 0.04)

func apply() -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		print("INIMIGO NO ESCUDO")
	if area.get_parent().get_meta("origin") == "enemy_shot":
		print("TIRO NO ESCUDO")
		area.get_parent().queue_free()
		queue_free() # Aplicar durabilidade no escudo

func _on_timer_timeout() -> void:
	queue_free()

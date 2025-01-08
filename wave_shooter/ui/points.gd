extends Label

func _process(delta: float) -> void:
	text = str("%03d" % Global.points)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		add_theme_color_override("font_color", Color(Color.WHITE, 0.5))

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		add_theme_color_override("font_color", Color(Color.WHITE, 1))

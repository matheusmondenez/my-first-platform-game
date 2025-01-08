extends Label

func _ready() -> void:
	text = str("%03d" % Global.high_score)

func _process(delta: float) -> void:
	if Global.points > Global.high_score:
		Global.high_score = Global.points

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		add_theme_color_override("font_color", Color(Color.WHITE, 0.5))

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		add_theme_color_override("font_color", Color(Color.WHITE, 1))

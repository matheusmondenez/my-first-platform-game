extends Control

@onready var points: Label = $Score/PointsContainer/Points
@onready var high_score: Label = $Score/PointsContainer/HighScore

func _on_points_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		change_points_area_opacity(0.5)

func _on_points_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		change_points_area_opacity(1)
	
func _on_life_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		change_life_area_opacity(0.5)

func _on_life_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		change_life_area_opacity(1)

func change_points_area_opacity(value: float) -> void:
	points.add_theme_color_override("font_color", Color(Color.WHITE, value))
	high_score.add_theme_color_override("font_color", Color(Color.WHITE, value))

func change_life_area_opacity(value: float) -> void:
	var children = get_children()
	for child in children:
		if child.name == "Life":
			var lifes = child.get_children()
			for life in lifes:
				if life is Polygon2D:
					life.color.a = value

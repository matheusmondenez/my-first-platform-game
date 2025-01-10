extends Polygon2D

signal powered_up

var shield_scene: PackedScene = preload("res://wave_shooter/actors/shield.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.player.power_ups.append("green")
		Global.player.add_child(shield_scene.instantiate())
		emit_signal("powered_up")
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

extends Polygon2D

signal powered_up

var shield_scene: PackedScene = preload("res://wave_shooter/entities/power_ups/shield.tscn")

func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2(1.3, 1.3), 0.07).from(Vector2(0.5, 0.5))
	tween.tween_property(self, "scale", Vector2(1, 1), 0.04)

func _process(delta: float) -> void:
	if $Timer.time_left < 3 and $Timer.time_left > 1:
		$Animation.play("blink")
	elif $Timer.time_left < 1:
		$Animation.speed_scale = 2

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.player.power_ups.append("green")
		Global.player.add_child(shield_scene.instantiate())
		emit_signal("powered_up")
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

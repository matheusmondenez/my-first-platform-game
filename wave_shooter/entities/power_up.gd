extends Polygon2D

signal powered_up

@onready var icon: TextureRect = $Icon

var shield_scene: PackedScene = preload("res://wave_shooter/entities/power_ups/shield.tscn")

func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(self, "scale", Vector2(1.3, 1.3), 0.07).from(Vector2(0.5, 0.5))
	#tween.tween_property(self, "scale", Vector2(1, 1), 0.04)

func _process(delta: float) -> void:
	if $Timer.time_left < 3 and $Timer.time_left > 1:
		$Animation.play("blink")
	elif $Timer.time_left < 1:
		$Animation.speed_scale = 2

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if get_meta("spawn_type") == "life":
			Global.player.lifes += 1
		elif get_meta("spawn_type") == "power_up":
			if get_meta("name") == "shield":
				Global.player.power_ups.append("shield")
				Global.player.add_child(shield_scene.instantiate())
			elif get_meta("name") == "triple_shot":
				Global.player.power_ups.append("triple_shot")
				var timer_triple_shot = get_tree().create_timer(5)
				timer_triple_shot.connect("timeout", func(): Global.player.power_ups.erase("triple_shot"))
			emit_signal("powered_up")
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

extends Polygon2D

var power

func _ready() -> void:
	#if power && power.props:
		#$Icon.texture = power.props.icon
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
		elif power.resource is BasePowerUp:
			PowerUpManager.activate(power.scene, power.resource.duration)
			#Global.player.add_child(power)
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

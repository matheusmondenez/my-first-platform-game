extends CPUParticles2D

func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	await tween.tween_property(self, "color:a", 0, 1).finished
	queue_free()

func _on_timer_timeout() -> void:
	emitting = false

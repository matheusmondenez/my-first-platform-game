extends CPUParticles2D

func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "color", Color("4a5fdd", 0), 1)

func _on_timer_timeout() -> void:
	emitting = false

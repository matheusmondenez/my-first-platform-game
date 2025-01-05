extends CPUParticles2D

func _on_emition_timer_timeout() -> void:
	#set_process(false)
	#set_physics_process(false)
	#set_process_input(false)
	#set_process_internal(false)
	#set_process_unhandled_input(false)
	#set_process_unhandled_key_input(false)
	#process_mode = ProcessMode.PROCESS_MODE_DISABLED
	emitting = false
	speed_scale = 0
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "color", Color("ab0b55", 0), 3)

extends State

func transition():
	if owner.init_chase:
		get_parent().change_state("Chase")

func _on_presentation_timer_timeout() -> void:
	owner.init_chase = true

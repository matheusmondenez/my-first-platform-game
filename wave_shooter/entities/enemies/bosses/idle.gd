extends State

func enter() -> void:
	super.enter()
	owner.idle = true
	owner.can_attack = false
	owner.can_dash = false
	owner.init_chase = false

func transition():
	if owner.init_chase:
		get_parent().change_state("Chase")
	elif owner.can_dash:
		get_parent().change_state("Dash")

func _on_presentation_timer_timeout() -> void:
	owner.init_chase = true

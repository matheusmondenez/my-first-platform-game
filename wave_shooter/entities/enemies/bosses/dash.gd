extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	super.enter()
	owner.idle = false
	owner.can_attack = false
	owner.can_dash = true
	owner.init_chase = false
	animation_player.play("dashing")

func transition() -> void:
	if owner.idle:
		get_parent().change_state("Idle")

extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	super.enter()
	owner.idle = false
	owner.can_attack = true
	owner.can_dash = false
	owner.init_chase = false
	animation_player.play("attacking")

func transition() -> void:
	if owner.init_chase:
		get_parent().change_state("Chase")

func _on_punch_range_body_exited(body: Node2D) -> void:
	owner.init_chase = true

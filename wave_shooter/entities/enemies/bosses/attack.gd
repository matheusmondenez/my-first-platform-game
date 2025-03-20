extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	super.enter()
	animation_player.play("attacking")

func transition() -> void:
	if owner.init_chase:
		get_parent().change_state("Chase")

func _on_punch_range_body_exited(body: Node2D) -> void:
	owner.can_attack = false
	owner.init_chase = true

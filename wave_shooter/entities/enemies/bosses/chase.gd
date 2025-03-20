extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("walking")

func exit() -> void:
	super.exit()
	owner.set_physics_process(false)

func transition() -> void:
	if owner.can_attack:
		get_parent().change_state("Attack")

func _on_punch_range_body_entered(body: Node2D) -> void:
	owner.init_chase = false
	owner.can_attack = true

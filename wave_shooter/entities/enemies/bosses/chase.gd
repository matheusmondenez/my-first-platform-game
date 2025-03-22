extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var chase_timer: Timer = $"../../ChaseTimer"

func enter() -> void:
	super.enter()
	owner.idle = false
	owner.can_attack = false
	owner.can_dash = false
	owner.init_chase = true
	chase_timer.start()
	owner.set_physics_process(true)
	animation_player.play("walking")

func exit() -> void:
	super.exit()
	owner.set_physics_process(false)

func transition() -> void:
	if owner.can_attack:
		chase_timer.stop()
		get_parent().change_state("Attack")
	elif owner.can_dash:
		get_parent().change_state("Dash")

func _on_punch_range_body_entered(body: Node2D) -> void:
	owner.can_attack = true

func _on_chase_timer_timeout() -> void:
	owner.can_dash = true

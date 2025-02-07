extends ColorRect

@onready var animation: AnimationPlayer = $Animation

var cooldown: float = 0.0:
	set(value):
		cooldown = value
		update_animation()

func _ready() -> void:
	material = material.duplicate()
	update_animation()

func update_animation():
	if cooldown <= 0:
		animation.stop()
		material.set_shader_parameter("cooldown_progress", 1.0)
		return
	animation.speed_scale = animation.get_animation("cooldown").length / cooldown
	animation.play("cooldown")

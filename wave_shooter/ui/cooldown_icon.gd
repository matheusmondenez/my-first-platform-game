extends ColorRect

@onready var teste: Label = $Teste
@onready var animation: AnimationPlayer = $Animation

var skill: BaseSkill = null

func _ready() -> void:
	if not skill:
		material.set_shader_parameter("cooldown_progress", 0)
	else:
		material = material.duplicate()
		teste.text = skill.name
		animation.speed_scale = animation.get_animation("cooldown").length / skill.cooldown
		animation.play("cooldown")

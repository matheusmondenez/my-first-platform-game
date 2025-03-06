extends ColorRect

@onready var teste: Label = $Teste
@onready var animation: AnimationPlayer = $Animation

var skill: BaseSkill = null:
	set(value):
		skill = value
		teste.text = skill.name

func _ready() -> void:
	if not skill:
		material.set_shader_parameter("cooldown_progress", 0)
	else:
		material = material.duplicate()
		material.set_shader_parameter("cooldown_progress", 1)
		teste.text = skill.name

func _process(delta: float) -> void:
	if skill && skill.is_cooling:
		animation.speed_scale = animation.get_animation("cooldown").length / skill.cooldown
		animation.play("cooldown")

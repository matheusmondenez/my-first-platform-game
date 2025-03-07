extends Sprite2D

@onready var animation: AnimationPlayer = $Animation

var skill: BaseSkill = null:
	set(value):
		skill = value
		material.set_shader_parameter("cooldown_progress", 1) # Para começar com a skill carregada
		texture = skill.icon

func _ready() -> void:
	if not skill:
		material.set_shader_parameter("cooldown_progress", 0)
	else:
		#material = material.duplicate()
		material.set_shader_parameter("cooldown_progress", 1)

func _process(delta: float) -> void:
	if skill && skill.is_cooling:
		animation.speed_scale = animation.get_animation("cooldown").length / skill.cooldown
		animation.play("cooldown")

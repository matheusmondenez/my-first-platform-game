extends ColorRect

var skill: PackedScene = null

func _ready() -> void:
	if not skill:
		$".".material.set_shader_parameter("cooldown_progress", 0)
	else:
		var props = Helpers.get_scene_resource_props(skill)
		material = material.duplicate()
		$Teste.text = props.name
		$Animation.speed_scale = $Animation.get_animation("cooldown").length / props.cooldown
		$Animation.play("cooldown")

extends TextureButton

@onready var skill:
	set(scene):
		skill = scene
		$Label.text = skill.props.name

func _on_pressed() -> void:
	SkillManager.assign(skill)

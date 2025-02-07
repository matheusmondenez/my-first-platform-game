extends TextureButton

@onready var label: Label = $Label

var skill: BaseSkill:
	set(resource):
		skill = resource
		update_label()

func _ready() -> void:
	update_label()

func update_label() -> void:
	if skill:
		label.text = skill.name

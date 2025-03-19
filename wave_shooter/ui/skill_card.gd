extends Control

var skill: Dictionary:
	set(value):
		skill = value
		title.text = skill["resource"].name
		description.text = skill["resource"].description

@onready var icon: TextureRect = $Button/Panel/MarginContainer/VBoxContainer/Icon
@onready var title: Label = $Button/Panel/MarginContainer/VBoxContainer/Title
@onready var description: Label = $Button/Panel/MarginContainer/VBoxContainer/Description

func _on_pressed() -> void:
	print("SKILL: ", skill)
	pass
	if skill["resource"].type == "Passive":
		Global.player.add_child(skill["scene"].instantiate())
	else:
		SkillManager.assign(skill, 3)

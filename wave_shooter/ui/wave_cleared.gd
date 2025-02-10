extends Control

@onready var button_skill_1: Button = $GeneralContainer/SkillsContainer/ButtonSkill1
@onready var button_skill_2: Button = $GeneralContainer/SkillsContainer/ButtonSkill2
@onready var button_skill_3: Button = $GeneralContainer/SkillsContainer/ButtonSkill3

var sorted_skills: Array

func _ready() -> void:
	display_cards()

func display_cards() -> void:
	sorted_skills = sort_skills()
	button_skill_1.text = sorted_skills[0].instantiate().props.name
	button_skill_2.text = sorted_skills[1].instantiate().props.name
	button_skill_3.text = sorted_skills[2].instantiate().props.name
	await Global.slow_time(0.2, 3)
	get_tree().paused = true

func sort_skills(quantity: int = 3) -> Array:
	return [
		SkillManager.available.pick_random(),
		SkillManager.available.pick_random(),
		SkillManager.available.pick_random(),
	]

func _on_button_skill_1_pressed() -> void:
	print("Assign Skill 1")
	SkillManager.assign(sorted_skills[0], 0)
	print("Assigned Skill 1: ", SkillManager.assigned)
	get_tree().reload_current_scene()

func _on_button_skill_2_pressed() -> void:
	print("Assign Skill 2")
	SkillManager.assign(sorted_skills[1], 1)
	print("Assigned Skill 2: ", SkillManager.assigned)
	get_tree().reload_current_scene()

func _on_button_skill_3_pressed() -> void:
	print("Assign Skill 3")
	SkillManager.assign(sorted_skills[2], 2)
	print("Assigned Skill 3: ", SkillManager.assigned)
	get_tree().reload_current_scene()

extends Control

@onready var button_skill_1: Button = $GeneralContainer/SkillsContainer/ButtonSkill1
@onready var button_skill_2: Button = $GeneralContainer/SkillsContainer/ButtonSkill2
@onready var button_skill_3: Button = $GeneralContainer/SkillsContainer/ButtonSkill3

var sorted_skills: Array[Dictionary]

func _ready() -> void:
	display_cards()

func display_cards() -> void:
	sorted_skills = sort_skills()
	button_skill_1.text = sorted_skills[0]["resource"].name if sorted_skills.size() > 0 else "Empty"
	button_skill_2.text = sorted_skills[1]["resource"].name if sorted_skills.size() > 1 else "Empty"
	button_skill_3.text = sorted_skills[2]["resource"].name if sorted_skills.size() > 2 else "Empty"
	await Global.slow_time(0.2, 3)
	get_tree().paused = true

func sort_skills(quantity: int = 3) -> Array[Dictionary]:
	return SkillManager.get_random(quantity)

func _on_button_skill_1_pressed() -> void:
	SkillManager.assign(sorted_skills[0], 0)
	#get_tree().reload_current_scene()
	get_tree().paused = false
	queue_free()

func _on_button_skill_2_pressed() -> void:
	SkillManager.assign(sorted_skills[1], 1)
	#get_tree().reload_current_scene()
	get_tree().paused = false
	queue_free()

func _on_button_skill_3_pressed() -> void:
	SkillManager.assign(sorted_skills[2], 2)
	#get_tree().reload_current_scene()
	get_tree().paused = false
	queue_free()

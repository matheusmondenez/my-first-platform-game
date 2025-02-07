extends Control

@onready var skill_card_1: TextureButton = $CardsContainer/SkillCard1
@onready var skill_card_2: TextureButton = $CardsContainer/SkillCard2
@onready var skill_card_3: TextureButton = $CardsContainer/SkillCard3

var temp1: BaseSkill
var temp2: BaseSkill
var temp3: BaseSkill
var sorted_skills: Array

func _ready() -> void:
	visibility_changed.connect(display_cards)

func display_cards() -> void:
	sorted_skills = sort_skills()
	skill_card_1.skill = sorted_skills[0]
	skill_card_2.skill = sorted_skills[1]
	skill_card_3.skill = sorted_skills[2]
	await Global.slow_time(0.2, 3)
	get_tree().paused = true

func sort_skills() -> Array:
	return Configs.SKILLS

func _on_skill_card_1_pressed() -> void:
	Global.assign_skill(1, skill_card_1.skill)
	get_tree().reload_current_scene()

func _on_skill_card_2_pressed() -> void:
	Global.assign_skill(2, skill_card_2.skill)
	get_tree().reload_current_scene()

func _on_skill_card_3_pressed() -> void:
	Global.assign_skill(3, skill_card_3.skill)
	get_tree().reload_current_scene()

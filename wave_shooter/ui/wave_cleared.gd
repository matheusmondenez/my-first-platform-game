extends Control

const SKILL_CARD_TSCN = preload("res://wave_shooter/ui/skill_card.tscn")
const SWEEP_SHOT_TSCN = preload("res://wave_shooter/entities/player/sweep_shot.tscn")

@onready var marker_1: Marker2D = $Marker1
@onready var marker_2: Marker2D = $Marker2
@onready var marker_3: Marker2D = $Marker3

var temp1: BaseSkill
var temp2: BaseSkill
var temp3: BaseSkill
var sorted_skills: Array

func _ready() -> void:
	display_cards()

func display_cards() -> void:
	#sorted_skills = sort_skills()
	#var card = SKILL_CARD_TSCN.instantiate()
	#var skill = SWEEP_SHOT_TSCN.instantiate()
	#card.skill = skill
	#add_child(card)
	await Global.slow_time(0.2, 3)
	get_tree().paused = true

func sort_skills() -> Array:
	return SkillManager.available

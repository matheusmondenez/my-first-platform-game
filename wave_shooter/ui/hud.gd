extends Control

enum LIVES_UPDATE { INCREASE, DECREASE }

const EXPLOSION_TSCN: PackedScene = preload("res://wave_shooter/fx/explosion.tscn")
const LIFE_TSCN: PackedScene = preload("res://wave_shooter/entities/life.tscn")
const SKILL_ICON: PackedScene = preload("res://wave_shooter/ui/cooldown_icon.tscn")

@onready var points: Label = $Score/PointsContainer/Points
@onready var high_score: Label = $Score/PointsContainer/HighScore
@onready var auto_shot_icon: TextureRect = $Score/PointsContainer/AutoShotToggle

@onready var skill_marker_1: Marker2D = $Skills/SkillMarker1
@onready var skill_marker_2: Marker2D = $Skills/SkillMarker2
@onready var skill_marker_3: Marker2D = $Skills/SkillMarker3
@onready var skill_marker_4: Marker2D = $Skills/SkillMarker4

var icon_1 = SKILL_ICON.instantiate()
var icon_2 = SKILL_ICON.instantiate()
var icon_3 = SKILL_ICON.instantiate()
var icon_4 = SKILL_ICON.instantiate()

func _ready() -> void:
	init_hud_lifes()
	SkillManager.skill_assigned.connect(update_skill_icon)
	high_score.text = str("%03d" % Global.high_score)
	Global.player.life_decreased.connect(update_hud_lifes.bind(LIVES_UPDATE.DECREASE))
	Global.player.life_increased.connect(update_hud_lifes.bind(LIVES_UPDATE.INCREASE))
	Global.parent_node_creation = self
	Global.points = 0
	# NOVO TESTE
	icon_1.label = "1" if SkillManager.assigned[0] else "0"
	icon_1.position = skill_marker_1.position
	icon_1.scale = Vector2(2, 2)
	add_child(icon_1)

	icon_2.label = "2" if SkillManager.assigned[1] else "0"
	icon_2.position = skill_marker_2.position
	icon_2.scale = Vector2(2, 2)
	add_child(icon_2)

	icon_3.label = "3" if SkillManager.assigned[2] else "0"
	icon_3.position = skill_marker_3.position
	icon_3.scale = Vector2(2, 2)
	add_child(icon_3)

	icon_4.label = "4" if SkillManager.assigned[3] else "0"
	icon_4.position = skill_marker_4.position
	icon_4.scale = Vector2(2, 2)
	add_child(icon_4)

func _process(delta: float) -> void:
	points.text = str("%03d" % Global.points)
	if Global.points > Global.high_score:
		Global.high_score = Global.points
	auto_shot_icon.visible = Configs.game_configs.auto_shot

func _on_points_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		change_points_area_opacity(0.5)

func _on_points_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		change_points_area_opacity(1)
	
func _on_life_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		change_life_area_opacity(0.5)

func _on_life_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("player"):
		change_life_area_opacity(1)

func change_points_area_opacity(value: float) -> void:
	points.add_theme_color_override("font_color", Color(Color.WHITE, value))
	high_score.add_theme_color_override("font_color", Color(Color.WHITE, value))

func change_life_area_opacity(value: float) -> void:
	var children = get_children()
	for child in children:
		if child.name == "Life":
			var lifes = child.get_children()
			for life in lifes:
				if life is Polygon2D:
					life.color.a = value

func init_hud_lifes() -> void:
	for life in Global.player.lifes:
		Global.instance_node(LIFE_TSCN, $Life/Markers.get_child(life).global_position, $Life)

func update_hud_lifes(type) -> void:
	if type == LIVES_UPDATE.INCREASE:
		add_hud_life()
	elif type == LIVES_UPDATE.DECREASE:
		remove_hud_life()

#func update_hud_power_ups() -> void:
	#print('Pegou Power Up!')
	#pass

func add_hud_life() -> void:
	Global.instance_node(LIFE_TSCN, $Life/Markers.get_child(Global.player.lifes - 1).global_position, $Life)

func remove_hud_life() -> void:
	var life = $Life.get_child($Life.get_child_count() - 1)
	var life_position = life.global_position
	life.queue_free()
	var explosion = Global.instance_node(EXPLOSION_TSCN, life_position, $Life)
	explosion.scale_amount_min = 5
	explosion.scale_amount_max = 17.5
	explosion.modulate = Color("c92e67")

func update_skill_icon(key: int, skill: PackedScene) -> void:
	print("ICON SKILL: ", key, skill)
	if key == 0:
		icon_1.label = "!"
	if key == 1:
		icon_2.label = "!"
	if key == 2:
		icon_3.label = "!"
	if key == 3:
		icon_4.label = "!"

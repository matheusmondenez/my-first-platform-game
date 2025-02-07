extends Control

enum LIVES_UPDATE { INCREASE, DECREASE }

const EXPLOSION_TSCN: PackedScene = preload("res://wave_shooter/fx/explosion.tscn")
const LIFE_TSCN: PackedScene = preload("res://wave_shooter/entities/life.tscn")

@onready var points: Label = $Score/PointsContainer/Points
@onready var high_score: Label = $Score/PointsContainer/HighScore
@onready var auto_shot_icon: TextureRect = $Score/PointsContainer/AutoShotToggle

@onready var skill_1_icon: ColorRect = $"Skills/1"
@onready var skill_2_icon: ColorRect = $"Skills/2"
@onready var skill_3_icon: ColorRect = $"Skills/3"
@onready var skill_4_icon: ColorRect = $"Skills/4"

func _ready() -> void:
	init_hud_lifes()
	high_score.text = str("%03d" % Global.high_score)
	Global.player.life_decreased.connect(update_hud_lifes.bind(LIVES_UPDATE.DECREASE))
	Global.player.life_increased.connect(update_hud_lifes.bind(LIVES_UPDATE.INCREASE))
	Global.parent_node_creation = self
	Global.points = 0
	# TESTE
	skill_1_icon.cooldown = 1
	skill_2_icon.cooldown = 5
	skill_3_icon.cooldown = 10
	skill_4_icon.cooldown = 15

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

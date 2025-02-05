extends Node2D

const EXPLOSION_TSCN: PackedScene = preload("res://wave_shooter/fx/explosion.tscn")
const LIFE_TSCN: PackedScene = preload("res://wave_shooter/entities/life.tscn")
const POWER_UP_TSCN = preload("res://wave_shooter/entities/power_up.tscn")

# Alterar de lifes para lives depois
enum LIFES_UPDATE {
	INCREASE,
	DECREASE
}

func _ready() -> void:
	Global.player.life_decreased.connect(update_hud_lifes.bind(LIFES_UPDATE.DECREASE))
	Global.player.life_increased.connect(update_hud_lifes.bind(LIFES_UPDATE.INCREASE))
	Global.parent_node_creation = self
	Global.points = 0
	init_hud_lifes()

func _exit_tree() -> void:
	Global.parent_node_creation = null

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_position = Vector2(randi_range(-160, 670), randi_range(-90, 390))
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(randi_range(-160, 670), randi_range(-90, 390))
	var enemy_index = round(randi_range(0, Configs.WAVES[1].enemies.size() - 1))
	Global.instance_node(Configs.WAVES[1].enemies[enemy_index], enemy_position, self)

func _on_dificulty_timer_timeout() -> void:
	if $EnemySpawnTimer.wait_time > 0.5:
		$DificultyTimer.wait_time -= 0.10

func _on_power_up_spawn_timer_timeout() -> void:
	var power_up_position = Vector2(randi_range(0, 1152), randi_range(0, 648))
	#var power_up_index = round(randi_range(0, Configs.WAVES[1].power_ups.size() - 1))
	var power_up = Global.instance_node(POWER_UP_TSCN, power_up_position, self, Configs.WAVES[1].power_ups[0])

func _on_life_spawn_timer_timeout() -> void:
	var life_position = Vector2(randi_range(0, 1152), randi_range(0, 648))
	var life = Global.instance_node(POWER_UP_TSCN, life_position, self)
	life.color = Color("ad0057")
	life.set_meta("spawn_type", "life")

func init_hud_lifes() -> void:
	for life in Global.player.lifes:
		Global.instance_node(LIFE_TSCN, $UI/HUD/Life/Markers.get_child(life).global_position, $UI/HUD/Life)

func add_hud_life() -> void:
	Global.instance_node(LIFE_TSCN, $UI/HUD/Life/Markers.get_child(Global.player.lifes - 1).global_position, $UI/HUD/Life) # Buga quando chega no limite

func remove_hud_life() -> void:
	var life = $UI/HUD/Life.get_child($UI/HUD/Life.get_child_count() - 1)
	var life_position = life.global_position
	life.queue_free()
	var explosion = Global.instance_node(EXPLOSION_TSCN, life_position, $UI/HUD/Life)
	explosion.scale_amount_min = 5
	explosion.scale_amount_max = 17.5
	explosion.modulate = Color("c92e67")

func update_hud_lifes(type) -> void:
	if type == LIFES_UPDATE.INCREASE:
		add_hud_life()
	elif type == LIFES_UPDATE.DECREASE:
		remove_hud_life()

func update_hud_power_ups() -> void:
	print('Pegou Power Up!')
	pass
	#var power_up = Global.instance_node(Configs.WAVES[1].power_ups[0]["icon"], $UI/HUD/PowerUps/Marker2D.global_position, $UI/HUD/PowerUps)

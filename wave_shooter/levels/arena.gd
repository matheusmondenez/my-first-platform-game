extends Node2D

const POWER_UP_TSCN = preload("res://wave_shooter/entities/power_up.tscn")
const WAVE_CLEARED_TSCN = preload("res://wave_shooter/ui/wave_cleared.tscn")

@onready var auto_shot_icon: TextureRect = $UI/HUD/Score/PointsContainer/AutoShotToggle

func _ready() -> void:
	Global.parent_node_creation = self

func _process(delta: float) -> void:
	#pass
	if Global.points >= 20:
		wave_cleared()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_auto_shot"):
		Configs.game_configs.auto_shot = !Configs.game_configs.auto_shot

func _exit_tree() -> void:
	Global.parent_node_creation = null

func wave_cleared() -> void:
	var wave_cleared = WAVE_CLEARED_TSCN.instantiate()
	wave_cleared.position = Vector2(1152/2, 648/2)
	add_child(wave_cleared)

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
	var power_up = PowerUpManager.get_random()
	#print("TESTE:: ", load("res://wave_shooter/resoures/power_ups/shield_power_up.tres").name)
	var power_up_spawn = POWER_UP_TSCN.instantiate()
	power_up_spawn.power = power_up.instantiate()
	power_up_spawn.global_position = power_up_position
	add_child(power_up_spawn)

func _on_life_spawn_timer_timeout() -> void:
	if Global.player.lifes == 10:
		return
	var life_position = Vector2(randi_range(0, 1152), randi_range(0, 648))
	var life = Global.instance_node(POWER_UP_TSCN, life_position, self)
	life.color = Color("ad0057")
	life.set_meta("spawn_type", "life")

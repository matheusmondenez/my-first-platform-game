extends Node2D

const Implosion = preload("res://wave_shooter/fx/implosion.tscn")
const Life = preload("res://wave_shooter/entities/life.tscn")
const PowerUp = preload("res://wave_shooter/entities/power_up.tscn")
const WaveCleared = preload("res://wave_shooter/ui/wave_cleared.tscn")

@onready var auto_shot_icon: TextureRect = $UI/HUD/Score/PointsContainer/AutoShotToggle

func _ready() -> void:
	Global.parent_node_creation = self
	SkillManager.clear_all_cooldowns() # Tem que manter os cooldowns mas o novo vir cheio pra poder usar
	Global.player.level_up.connect(wave_cleared)

func _process(delta: float) -> void:
	pass

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_auto_shot"):
		Configs.game_configs.auto_shot = !Configs.game_configs.auto_shot

func _exit_tree() -> void:
	Global.parent_node_creation = null

func wave_cleared() -> void:
	var wave_cleared = WaveCleared.instantiate()
	wave_cleared.position = Vector2(1920/2, 1080/2) # Rever solução
	add_child(wave_cleared)

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_position = Vector2(randi_range(-160, 670), randi_range(-90, 390))
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(randi_range(-160, 670), randi_range(-90, 390))
	var enemy_index = round(randi_range(0, Configs.WAVES[1].enemies.size() - 1))
	# spawn effect
	var implosion = Implosion.instantiate()
	implosion.global_position = enemy_position
	add_child(implosion)
	await get_tree().create_timer(1).timeout
	implosion.queue_free()
	# spawn effect
	Global.instance_node(Configs.WAVES[1].enemies[enemy_index], enemy_position, self)

func _on_dificulty_timer_timeout() -> void:
	if $EnemySpawnTimer.wait_time > 0.5:
		$DificultyTimer.wait_time -= 0.10

#func _on_power_up_spawn_timer_timeout() -> void:
	#var power_up_position = Vector2(randi_range(0, 1152), randi_range(0, 648))
	#var power_up = PowerUpManager.get_random()
	#var power_up_spawn = PowerUp.instantiate()
	#power_up_spawn.power = power_up
	#power_up_spawn.color = power_up.resource.tint
	#power_up_spawn.global_position = power_up_position
	#power_up_spawn.scale = Vector2(2, 2)
	#add_child(power_up_spawn)

#func _on_life_spawn_timer_timeout() -> void:
	#if Global.player.lifes == 10:
		#return
	#var life_position = Vector2(randi_range(0, 1152), randi_range(0, 648))
	##var life = Global.instance_node(PowerUp, life_position, self)
	#var life = PowerUp.instantiate()
	#life.global_position = life_position
	#life.scale = Vector2(2, 2)
	#life.color = Color("ad0057")
	#life.set_meta("spawn_type", "life")
	#add_child(life)

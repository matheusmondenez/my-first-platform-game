extends Node2D

var enemy_one: PackedScene = preload("res://wave_shooter/actors/enemy.tscn")
var enemies = [
	preload("res://wave_shooter/actors/enemy.tscn"),
	preload("res://wave_shooter/actors/speedy_enemy.tscn"),
]

func _ready() -> void:
	Global.parent_node_creation = self
	Global.points = 0

func _exit_tree() -> void:
	Global.parent_node_creation = null

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_position = Vector2(randi_range(-160, 670), randi_range(-90, 390))
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(randi_range(-160, 670), randi_range(-90, 390))
	var enemy = round(randi_range(0, enemies.size() - 1))
	Global.instance_node(enemies[enemy], enemy_position, self)

func _on_dificulty_timer_timeout() -> void:
	if $EnemySpawnTimer.wait_time > 0.5:
		$DificultyTimer.wait_time -= 0.10

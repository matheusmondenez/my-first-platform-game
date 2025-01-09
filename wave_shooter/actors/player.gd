extends Polygon2D

signal life_decreased

#var stats: BaseStats
@export var lifes: int = 3
var speed: int = 500
var move: Vector2 = Vector2.ZERO
var projectile_scene: PackedScene = preload("res://wave_shooter/actors/projectile.tscn")
var explosion_scene: PackedScene = preload("res://wave_shooter/actors/explosion.tscn")
var is_loaded: bool = true
var is_dead: bool = false
var powered_up: Array = []

func _ready() -> void:
	Global.player = self

func _process(delta: float) -> void:
	move.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	global_position.x = clamp(global_position.x, 24, 1127)
	global_position.y = clamp(global_position.y, 24, 624)
	if not is_dead:
		global_position += speed * move * delta
	if Input.is_action_pressed("shoot") and Global.parent_node_creation and is_loaded and not is_dead:
		Global.instance_node(projectile_scene, global_position, Global.parent_node_creation)
		is_loaded = false
		$Timer.start()

func _on_timer_timeout() -> void:
	is_loaded = true

func _exit_tree() -> void:
	Global.player = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().queue_free()
		take_damage(1)
		if lifes <= 0:
			die()
		emit_signal("life_decreased")

func take_damage(damage: int) -> void:
	Global.camera.shake_screen(100, 0.2)
	lifes -= damage

func die() -> void:
	$Area2D.monitoring = false
	$Area2D.monitorable = false
	is_dead = true
	visible = false
	var explosion = Global.instance_node(explosion_scene, global_position, Global.parent_node_creation)
	explosion.modulate = Color("4a5fdd")
	await Global.slow_time(0.2, 3)
	get_tree().reload_current_scene()

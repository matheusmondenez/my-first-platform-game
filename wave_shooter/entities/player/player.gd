extends Polygon2D

signal life_decreased
signal life_inreased

@export var lifes: int = 3
	#set(value): emit_signal("life_decreased")

var speed: int = 250
var projectile_scene: PackedScene = preload("res://wave_shooter/entities/player/projectile.tscn")
var explosion_scene: PackedScene = preload("res://wave_shooter/fx/explosion.tscn")
var screen_damage_scene: PackedScene = preload("res://wave_shooter/ui/screen_damage.tscn")
var is_loaded: bool = true
var is_dead: bool = false
var power_ups: Array = []

func _ready() -> void:
	Global.player = self

#region _process
func _process(delta: float) -> void:
	if not is_dead:
		move(delta)
	if Input.is_action_pressed("shoot") and Global.parent_node_creation and is_loaded and not is_dead:
		shot()
	if Input.is_action_just_pressed("dash"):
		dash()
#endregion

func _on_timer_timeout() -> void:
	is_loaded = true

func _exit_tree() -> void:
	Global.player = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		#var enemy_move = area.get_parent().move
		area.get_parent().queue_free()
		take_damage(1)
		if lifes <= 0:
			die()
		emit_signal("life_decreased")

func move(delta) -> void:
	var motion: Vector2 = Vector2.ZERO
	motion = Input.get_vector("left", "right", "up", "down")
	global_position = Vector2(clamp(global_position.x, 24, 1127), clamp(global_position.y, 24, 624))
	global_position += speed * motion * delta

func dash() -> void:
	print("DASH")
	#global_position += speed * move * delta * 6

func shot() -> void:
	Global.instance_node(projectile_scene, global_position, Global.parent_node_creation)
	if power_ups.find("triple_shot") >= 0:
		var left_shot = Global.instance_node(projectile_scene, global_position, Global.parent_node_creation)
		left_shot.angle = 345
		var right_shot = Global.instance_node(projectile_scene, global_position, Global.parent_node_creation)
		right_shot.angle = -345
	is_loaded = false
	$Timer.start()

func take_damage(damage: int, knokback: Vector2 = Vector2.ZERO) -> void:
	Global.camera.shake_screen(100, 0.2)
	var screen_damage = Global.instance_node(screen_damage_scene, Vector2(576, 324), Global.camera)
	screen_damage.modulate = Color("4a5fdd")
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

extends Polygon2D

var stats: BaseStats
var speed: int = 500
var move: Vector2 = Vector2.ZERO
var projectile_scene: PackedScene = preload("res://wave_shooter/actors/projectile.tscn")
var is_loaded: bool = true
var is_dead: bool = false

func _ready() -> void:
	Global.player = self

func _process(delta: float) -> void:
	move.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
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
		is_dead = true
		visible = false
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()

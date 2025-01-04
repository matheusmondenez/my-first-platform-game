extends Polygon2D

var stats: BaseStats
var speed: int = 500
var move: Vector2 = Vector2.ZERO
var projectile_scene: PackedScene = preload("res://wave_shooter/actors/projectile.tscn")
var loaded: bool = true

func _ready() -> void:
	Global.player = self

func _process(delta: float) -> void:
	move.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	global_position += speed * move * delta
	if Input.is_action_pressed("shoot") and Global.parent_node_creation and loaded:
		Global.instance_node(projectile_scene, global_position, Global.parent_node_creation)
		loaded = false
		$Timer.start()

func _on_timer_timeout() -> void:
	loaded = true

func _exit_tree() -> void:
	Global.player = null

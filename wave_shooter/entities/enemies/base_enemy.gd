extends Polygon2D

class_name BaseEnemy

const BLOOD_TSCN: PackedScene = preload("res://wave_shooter/fx/blood.tscn")

@export_category("Stats")
@export var stats: BaseEnemyStats

#@export var hp: int = 3
#@export var speed: int = 75
#@export var knockback: int = 6

var motion: Vector2 = Vector2.ZERO
var is_stunned: bool = false

#region lifecicle
func _ready() -> void:
	stats = stats.duplicate(true)
	color = stats.tint

#region _process
func _process(delta: float) -> void:
	chase_player(delta)
	if stats.life <= 0 and Global.parent_node_creation:
		die()
#endregion
#endregion

func chase_player(delta) -> void:
	if Global.player and not is_stunned:
		motion = global_position.direction_to(Global.player.global_position)
	elif is_stunned:
		motion = lerp(motion, Vector2.ZERO, 0.3)
	global_position += motion * stats.speed * delta
	
func die() -> void:
	if Global.camera:
		Global.camera.shake_screen(50, 0.1)
	var blood = Global.instance_node(BLOOD_TSCN, global_position, Global.parent_node_creation)
	blood.rotation = motion.angle()
	queue_free()
	Global.points += 10
	Global.enemies_count += 1

#region signals
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage") and not is_stunned:
		stats.life -= 1
		is_stunned = true
		color = Color.WHITE
		if area.name == "Shield":
			print("ESCUDADA")
			motion = -motion * 60000
		else:
			motion = -motion * stats.knockback_force
		area.get_parent().queue_free()
		$Timer.start()

func _on_timer_timeout() -> void:
	is_stunned = false
	color = Color("c92e67")
#endregion

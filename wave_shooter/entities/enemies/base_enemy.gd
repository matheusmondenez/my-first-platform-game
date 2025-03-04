class_name BaseEnemy extends Polygon2D

const BLOOD_TSCN: PackedScene = preload("res://wave_shooter/fx/blood.tscn")
const PROJECTILE_TSCN: PackedScene = preload("res://wave_shooter/entities/projectile/projectile.tscn")

@export_category("Stats")
@export var stats: BaseEnemyStats

var direction: Vector2 = Vector2.ZERO
var can_shoot: bool = true

#region lifecicle
func _ready() -> void:
	stats = stats.duplicate(true) # Não precisa disso se marar o Resource > Local to Scene
	color = stats.tint

#region _process
func _process(delta: float) -> void:
	chase_player(delta)
	if can_shoot:
		can_shoot = false
		await get_tree().create_timer(2).timeout
		#shoot()
		can_shoot = true
	if stats.life <= 0 and Global.parent_node_creation:
		die()
#endregion
#endregion

func chase_player(delta) -> void:
	if Global.player:
		direction = global_position.direction_to(Global.player.global_position)
	global_position += direction * stats.speed * delta # Verifiar a necessidade de normalizar o vetor de direction

func shoot() -> void:
	var projectile = PROJECTILE_TSCN.instantiate()
	projectile.target = Global.player.global_position
	projectile.direction = global_position.direction_to(Global.player.global_position)
	projectile.set_meta("origin", "enemy_shot")
	add_child(projectile)

func take_damage(damage) -> void:
	stats.life -= damage
	knockback()

func knockback() -> void:
	#direction = lerp(direction, Vector2.ZERO, 0.3)
	direction = -direction.normalized() * 6
	create_tween().tween_property(self, "global_position", global_position + 6 * direction, 0.3)

func die() -> void:
	if Global.camera:
		Global.camera.shake_screen(50, 0.1)
	var blood = Global.instance_node(BLOOD_TSCN, global_position, Global.parent_node_creation)
	blood.color = stats.tint
	blood.rotation = fmod(direction.angle() - deg_to_rad(180), 360)
	queue_free()
	Global.points += 10
	Global.enemies_count += 1

#region signals
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage"):
		var shot = area.get_parent()
		take_damage(shot.power)
		color = Color.WHITE
		area.get_parent().queue_free()
#endregion

class_name Enemy extends CharacterBody2D

const Blood: PackedScene = preload("res://wave_shooter/fx/blood.tscn")
const XPGem: PackedScene = preload("res://wave_shooter/entities/xp_gem.tscn")
const Projectile: PackedScene = preload("res://wave_shooter/entities/projectile/projectile.tscn")

@export_category("Stats")
@export var stats: BaseEnemyStats

var direction: Vector2 = Vector2.ZERO
var can_shoot: bool = true

#region lifecicle
func _ready() -> void:
	$Sprite/Enemy.color = stats.tint

#region _process
func _process(delta: float) -> void:
	chase_player(delta)
	if can_shoot:
		can_shoot = false
		await get_tree().create_timer(2).timeout
		#shoot()
		can_shoot = true
#endregion
#endregion

func chase_player(delta) -> void:
	if Global.player:
		direction = global_position.direction_to(Global.player.global_position)
	global_position += direction * stats.speed * delta # Verifiar a necessidade de normalizar o vetor de direction

func shoot() -> void:
	var projectile = Projectile.instantiate()
	projectile.target = Global.player.global_position
	projectile.direction = global_position.direction_to(Global.player.global_position)
	projectile.set_meta("origin", "enemy_shot")
	add_child(projectile)

func take_damage(damage) -> void:
	$Sprite/Enemy.color = Color("fff")
	stats.life -= damage
	knockback()
	if stats.life <= 0:
		die()
	await get_tree().create_timer(0.1).timeout
	$Sprite/Enemy.color = Color(stats.tint)

func knockback() -> void:
	#direction = lerp(direction, Vector2.ZERO, 0.3)
	direction = -direction.normalized() * 6
	create_tween().tween_property(self, "global_position", global_position + 6 * direction, 0.1)

func die() -> void:
	if Global.camera:
		Global.camera.shake_screen(50, 0.1)
	Global.instance_node(XPGem, global_position, Global.parent_node_creation)
	var blood = Global.instance_node(Blood, global_position, Global.parent_node_creation)
	blood.color = stats.tint
	blood.rotation = direction.angle()
	Global.points += 10
	Global.enemies_count += 1
	queue_free()

#region signals
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage"):
		var shot = area.get_parent()
		take_damage(shot.power)
		area.get_parent().queue_free()
#endregion

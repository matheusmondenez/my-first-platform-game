extends Polygon2D

class_name BaseEnemy

@export var hp: int = 3
@export var speed: int = 75
@export var knockback: int = 6
var move: Vector2 = Vector2.ZERO
var is_stunned: bool = false
var blood_scene: PackedScene = preload("res://wave_shooter/actors/blood.tscn")

func _process(delta: float) -> void:
	chase_player(delta) # Verificar porque este process pai não é executado quando o filho tem seu próprio process
	if hp <= 0 and Global.parent_node_creation:
		if Global.camera:
			Global.camera.shake_screen(50, 0.1)
		var blood = Global.instance_node(blood_scene, global_position, Global.parent_node_creation)
		blood.rotation = move.angle()
		queue_free()
		Global.points += 10
		Global.enemies_count += 1

func chase_player(delta) -> void:
	if Global.player and not is_stunned:
		move = global_position.direction_to(Global.player.global_position)
	elif is_stunned:
		move = lerp(move, Vector2.ZERO, 0.3)
	global_position += move * speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage") and not is_stunned:
		hp -= 1
		is_stunned = true
		color = Color.WHITE
		if area.name == "Shield":
			print("ESCUDADA")
			move = -move * 60000
		else:
			move = -move * knockback
		area.get_parent().queue_free()
		$Timer.start()

func _on_timer_timeout() -> void:
	is_stunned = false
	color = Color("c92e67")

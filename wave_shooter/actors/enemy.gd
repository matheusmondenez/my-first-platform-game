extends Polygon2D

var hp: int = 3
var speed: int = 75
var move: Vector2 = Vector2.ZERO
var is_stunned: bool = false
var knockback: int = 6

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Global.player and not is_stunned:
		move = global_position.direction_to(Global.player.global_position)
	elif is_stunned:
		move = lerp(move, Vector2.ZERO, 0.3)
	global_position += move * speed * delta
	if hp <= 0:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage"):
		hp -= 1
		is_stunned = true
		#modulate = Color.WHITE
		area.get_parent().queue_free()
		move = -move * knockback
		$Timer.start()

func _on_timer_timeout() -> void:
	is_stunned = false
	#modulate = Color("c92e67")

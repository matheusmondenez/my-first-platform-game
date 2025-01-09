extends Control

var time_left: int = 5

func _ready() -> void:
	get_tree().paused = true
	tween_label()

func _on_timer_timeout() -> void:
	tween_label()
	time_left -= 1
	$Counter.text = str("%1d" % time_left)
	reset_tween()
	if time_left < 0:
		$Counter.text = "Wave 1"
		await get_tree().create_timer(1).timeout
		get_tree().paused = false
		queue_free()

func tween_label() -> void:
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_parallel()
	tween.tween_property($Counter, "modulate:a", 0, 0.5)
	tween.tween_property($Counter, "scale", Vector2.ZERO, 0.5)
	tween.tween_property($Counter, "position", get_viewport_rect().size / 2, 0.5)
	#tween.tween_property(
		#$Counter,
		#"position",
		#Vector2(
			#528 + 48, # Original $Counter.global_position.x + $Counter.global_position.x / ($Counter.size.x / 2)
			#242 + 82  # Original $Counter.global_position.y + $Counter.global_position.y / ($Counter.size.y / 2)
		#),
		#0.5
	#)

func reset_tween() -> void:
	$Counter.modulate.a = 1
	$Counter.scale = Vector2(1, 1)

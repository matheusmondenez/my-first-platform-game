extends Control

var time_left: int = 5

func _ready() -> void:
	get_tree().paused = true

func _process(delta: float) -> void:
	pass
	#$Counter.text = str("%01d" % $Timer.time_left)
	#var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_loops()
	#tween.tween_property($Counter, "modulate:a", 0, 0.5)
	#tween.tween_property($Counter, "modulate:a", 1, 0.1)

func _on_timer_timeout() -> void:
	time_left -= 1
	$Counter.text = str("%1d" % time_left)
	if time_left < 0:
		get_tree().paused = false
		queue_free()

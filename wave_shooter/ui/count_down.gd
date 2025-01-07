extends Control

func _ready() -> void:
	get_tree().paused = true

func _process(delta: float) -> void:
	$Counter.text = str("%01d" % $Timer.time_left)

func _on_timer_timeout() -> void:
	get_tree().paused = false
	queue_free()

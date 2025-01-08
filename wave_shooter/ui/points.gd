extends Label

func _process(delta: float) -> void:
	text = str("%03d" % Global.points)

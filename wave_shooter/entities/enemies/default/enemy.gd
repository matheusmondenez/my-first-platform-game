extends Enemy

func _process(delta: float) -> void:
	super._process(delta)
	#if global_position.distance_to(Global.player.global_position) < 100:
		#stats.speed = 0

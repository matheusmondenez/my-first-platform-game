extends Label

func _ready() -> void:
	text = str("%03d" % Global.high_score)

func _process(delta: float) -> void:
	if Global.points > Global.high_score:
		Global.high_score = Global.points

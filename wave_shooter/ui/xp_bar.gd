extends Control

@onready var left_side: ProgressBar = $LeftSide
@onready var right_side: ProgressBar = $RightSide

func _process(delta: float) -> void:
	left_side.min_value = 0 if Global.level == 1 else Global.LEVELS[Global.level - 1]["max_xp"]
	right_side.min_value = 0 if Global.level == 1 else Global.LEVELS[Global.level - 1]["max_xp"]
	left_side.max_value = Global.LEVELS[Global.level]["max_xp"]
	right_side.max_value = Global.LEVELS[Global.level]["max_xp"]
	left_side.value = Global.xp
	right_side.value = Global.xp

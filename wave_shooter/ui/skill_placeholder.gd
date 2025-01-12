extends ColorRect

@export var key: int = 1

func _ready() -> void:
	$Label.text = str(key)

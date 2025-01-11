extends ColorRect

@export var cooldown: float = 1 # Tempo de cooldown em segundos

func _ready() -> void:
	$Animation.speed_scale /= cooldown

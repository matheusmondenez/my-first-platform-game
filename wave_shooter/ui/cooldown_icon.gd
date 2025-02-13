extends ColorRect

var cooldown: float
var label: String

func _ready() -> void:
	print("CD: ", cooldown)
	material = material.duplicate()
	$Teste.text = label
	$Animation.speed_scale = $Animation.get_animation("cooldown").length / cooldown
	$Animation.play("cooldown")

extends AnimatedSprite2D

@onready var character_body_2d: CharacterBody2D = $".."

func _on_animation_finished() -> void:
	if (self.animation == "assembling"):
		character_body_2d.is_assembling = false
	elif (self.animation == "disassembling"):
		get_tree().reload_current_scene()

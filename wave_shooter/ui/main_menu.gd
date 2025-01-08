extends Control

func _ready() -> void:
	$Version.text = str(Configs.VERSION)

func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://wave_shooter/levels/arena.tscn")

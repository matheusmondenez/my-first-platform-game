extends Control

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://wave_shooter/ui/main_menu.tscn")

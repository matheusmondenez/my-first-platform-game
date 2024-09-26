extends Node

@onready var panel: Panel = %Panel

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("pause")):
		get_tree().paused = true
		panel.show()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	panel.hide()
 
func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")

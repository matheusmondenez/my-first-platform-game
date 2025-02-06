extends Control

func _ready() -> void:
	visibility_changed.connect(func(): 
		print("TESTE WAVE")
		await Global.slow_time(0.2, 3)
		get_tree().reload_current_scene()
	)

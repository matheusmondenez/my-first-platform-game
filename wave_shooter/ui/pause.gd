extends Control

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") && get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") && get_tree().paused == true:
		resume()

func pause() -> void:
	visible = true
	get_tree().paused = true

func resume() -> void:
	visible = false
	get_tree().paused = false

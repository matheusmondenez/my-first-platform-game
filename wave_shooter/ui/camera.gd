extends Camera2D

var shake_intensity: int = 0
var is_shaking: bool = false

func _ready() -> void:
	Global.camera = self

func _process(delta: float) -> void:
	zoom = lerp(zoom, Vector2(1, 1), 0.3)
	if is_shaking:
		global_position += Vector2(randi_range(-shake_intensity, shake_intensity), randi_range(-shake_intensity, shake_intensity)) * delta

func shake_screen(intensity, time):
	zoom = Vector2(1, 1) - Vector2(intensity * 0.002, intensity * 0.002)
	shake_intensity = intensity
	$Timer.wait_time = time
	$Timer.start()
	is_shaking = true

func _on_timer_timeout() -> void:
	is_shaking = false

func _exit_tree() -> void:
	Global.camera = null

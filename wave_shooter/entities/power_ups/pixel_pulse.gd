extends CPUParticles2D

@export var props: BaseSkill

@onready var shape: CollisionShape2D = $Area/Shape
@onready var interval: Timer = $Interval
@onready var active_timer: Timer = $ActiveTimer

func _ready() -> void:
	active_timer.start()

func _process(delta: float) -> void:
	pass

func _on_interval_timeout() -> void:
	emitting = true
	shape.disabled = false
	active_timer.start()

func _on_active_timer_timeout() -> void:
	emitting = false
	shape.disabled = true
	interval.start()

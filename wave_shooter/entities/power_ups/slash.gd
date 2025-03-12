extends Sprite2D

@export var props: BaseSkill

@onready var area: Area2D = $Area
@onready var shape: CollisionShape2D = $Area/Shape
@onready var interval: Timer = $Interval
@onready var active_timer: Timer = $ActiveTimer

func _ready() -> void:
	activate()

func activate() -> void:
	shape.disabled = true
	interval.start()

func _on_interval_timeout() -> void:
	shape.disabled = false
	active_timer.start()

func _on_active_timer_timeout() -> void:
	shape.disabled = true
	interval.start()

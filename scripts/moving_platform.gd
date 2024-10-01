extends Node2D

const WAIT_DURATION := 1.0

@onready var platform := $Platform as AnimatableBody2D

@export var speed := 3.0
@export var distance := 192
@export var is_horizontal := true  

var follow := Vector2.ZERO
var platform_center :=  24

func _ready() -> void:
	move()

func _physics_process(delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)

func move() -> void:
	var direction = Vector2.RIGHT * distance if is_horizontal else Vector2.UP * distance
	var duration = direction.length() / float(speed * platform_center)
	var tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "follow", direction, duration)
	tween.tween_property(self, "follow", Vector2.ZERO, duration)
	

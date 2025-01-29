extends Resource

class_name BaseShot

@export var sprite: PackedScene
@export var tint: Color
@export var speed: int
@export var damage: int
@export_range(1, 10, 0.1) var knockback_force

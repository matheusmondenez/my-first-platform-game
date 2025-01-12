extends Resource

class_name BasePowerUp

@export var title: String
@export var tint: Color
@export_range(0, 1, 0.1) var spawn_rate
@export_range(3, 10, 0.1) var available_time
@export_range(3, 10, 0.1) var life_time

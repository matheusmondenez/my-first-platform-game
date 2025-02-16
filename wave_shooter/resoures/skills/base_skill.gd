class_name BaseSkill extends Resource

@export var name: String
@export_enum("Attack", "Defense") var type: String
@export var power: int
@export var cooldown: float
@export var is_cooling: bool

class_name BaseSkill extends Resource

@export var name: String
@export var icon: Texture2D
@export_enum("Attack", "Defense", "Passive") var type: String
@export var power: int
@export var cooldown: float
@export var is_cooling: bool

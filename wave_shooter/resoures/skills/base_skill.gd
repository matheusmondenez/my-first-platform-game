class_name BaseSkill extends Resource

@export var icon: Texture2D
@export var name: String
@export_multiline var description: String
@export_enum("Attack", "Defense", "Passive") var type: String
@export var power: int
@export var cooldown: float
@export var is_cooling: bool

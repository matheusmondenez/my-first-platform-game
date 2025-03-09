extends Label

@export var props: BasePowerUp

func _ready() -> void:
	Global.player.get_node("ShotInterval").wait_time = 0.1
	await get_tree().create_timer(props.duration).timeout
	Global.player.get_node("ShotInterval").wait_time = 0.2
	queue_free()

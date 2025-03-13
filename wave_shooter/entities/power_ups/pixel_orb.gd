extends Sprite2D

const PierceShot: PackedScene = preload("res://wave_shooter/entities/player/pierce_shot.tscn")

@onready var detection_area: Area2D = $DetectionArea
@onready var shot_area: Area2D = $ShotArea
@onready var shot_interval: Timer = $ShotInterval

var can_shot: bool = true

func _process(delta: float) -> void:
	var bodies = detection_area.get_overlapping_bodies()
	var distances: Array = []

	for body in bodies:
		if body.is_in_group("enemy"):
			var distance = body.global_position.distance_to(global_position)
			distances.append(distance)
	for body in bodies:
		if body.is_in_group("enemy"):
			var distance = body.global_position.distance_to(global_position)
			if distance == distances.min():
				var orb = self
				orb.global_position = orb.global_position.move_toward(body.global_position, 10)
				var distance_to_player = orb.global_position.distance_to(Global.player.global_position)
				if distance_to_player > 100:
					var direction_to_player = (Global.player.global_position - orb.global_position).normalized()
					orb.global_position = Global.player.global_position - direction_to_player * 100
				if shot_area.get_overlapping_bodies().has(body) and can_shot:
					var pierce_shot = PierceShot.instantiate()
					pierce_shot.pierce = false
					pierce_shot.target = body.global_position
					orb.add_child(pierce_shot)
					can_shot = false
					shot_interval.start()

func _on_shot_interval_timeout() -> void:
	can_shot = true

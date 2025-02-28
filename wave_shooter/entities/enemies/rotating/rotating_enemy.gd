extends Polygon2D

const PROJECTILE_TSCN = preload("res://wave_shooter/entities/projectile/projectile.tscn")

@onready var shoot_timer: Timer = $Timer
@onready var rotater: Sprite2D = $Rotater

const rotate_speed = 100
const shoot_timer_wait_time = 0.1
const spawn_point_count = 4
const radius = 100

func _ready():	
	var step = 2 * PI / spawn_point_count
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()

func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func _on_timer_timeout():
	for s in rotater.get_children():
		var bullet = PROJECTILE_TSCN.instantiate()
		bullet.unique_direction = false
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation

extends CharacterBody2D

const Projectile: PackedScene = preload("res://wave_shooter/entities/projectile/projectile.tscn")

@onready var body: Sprite2D = $Body
@onready var left_hand: Sprite2D = $LeftHand
@onready var right_hand: Sprite2D = $RightHand
@onready var left_eye: Marker2D = $Body/LeftEye
@onready var right_eye: Marker2D = $Body/RightEye
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var punch_range: Area2D = $PunchRange

var left_hand_original_position := Vector2.ZERO
var right_hand_original_position := Vector2.ZERO
var direction := Vector2.ZERO
var idle_counter: int = 0
var can_shot: bool = true
var can_punch: bool = true

func _ready() -> void:
	left_hand_original_position = left_hand.position
	right_hand_original_position = right_hand.position

func _physics_process(delta: float) -> void:
	if idle_counter == 3:
		animation_player.stop()
		prepare_attack()
	else:
		#chase_player(delta)
		animation_player.play("idle")

func increment_idle_counter() -> void:
	idle_counter += 1

func chase_player(delta) -> void:
	if Global.player:
		direction = global_position.direction_to(Global.player.global_position)
	global_position += direction * 100 * delta # Verifiar a necessidade de normalizar o vetor de direction

func prepare_attack() -> void:
	left_hand.position.y = randi_range(left_hand_original_position.y - 2, left_hand_original_position.y + 2)
	right_hand.position.y = randi_range(right_hand_original_position.y - 2, right_hand_original_position.y + 2)
	await get_tree().create_timer(1).timeout
	left_hand.position = left_hand_original_position
	right_hand.position = right_hand_original_position
	idle_counter = 0
	var bodies = punch_range.get_overlapping_bodies()
	if bodies.size() > 0:
		for body in bodies:
			if body.name == "Player":
				if can_punch:
					punch()
	else:
		if can_shot:
			shoot()

func punch() -> void:
	can_punch = false
	await create_tween().set_ease(Tween.EASE_IN_OUT).tween_property(left_hand, "global_position", Global.player.global_position, 1).finished
	await create_tween().set_ease(Tween.EASE_IN_OUT).tween_property(left_hand, "position", left_hand_original_position, 1).finished
	await get_tree().create_timer(1).timeout
	can_punch = true

func shoot() -> void:
	can_shot = false
	var projectile = Projectile.instantiate()
	projectile.target = Global.player.global_position
	projectile.direction = global_position.direction_to(Global.player.global_position)
	projectile.set_meta("origin", "enemy_shot")
	left_eye.add_child(projectile)
	await get_tree().create_timer(1).timeout
	can_shot = true

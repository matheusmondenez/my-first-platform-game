extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var idle := true
var can_attack := false
var can_dash := false
var init_chase := false
var direction := Vector2.ZERO

func _ready() -> void:
	animation_player.play("idle")
	set_physics_process(false)

func _process(delta: float) -> void:
	direction = Global.player.position - position

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

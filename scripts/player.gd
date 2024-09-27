extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -900.0

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var knockback_active = false
var knockback_timer = 0.2
var knockback_direction = 1

func _physics_process(delta: float) -> void:
	set_animation(delta)

	if knockback_active:
		velocity.x = knockback_direction * 500
		knockback_timer -= delta
		
		if knockback_timer <= 0:
			knockback_active = false
	else:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump()

		var direction := Input.get_axis("left", "right")
		
		set_face_direction(direction)
		
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func set_animation(delta):
	if is_on_floor():
		if velocity.x > 1 || velocity.x < -1:
			sprite_2d.animation = "running"
		else:
			sprite_2d.animation = "idle"
	else:
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"

func set_face_direction(direction):
	if (direction < 0):
		sprite_2d.flip_h = true
	elif (direction > 0):
		sprite_2d.flip_h = false
		
func jump():
	velocity.y = JUMP_VELOCITY
	
func knockback(direction):
	velocity.y = -500
	knockback_direction = direction
	knockback_active = true
	knockback_timer = 0.2

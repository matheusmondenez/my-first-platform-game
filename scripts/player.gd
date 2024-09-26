extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -900.0

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	set_animation(delta)

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	set_face_direction(direction)

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
	
func jump_side(x):
	print("jump_side: ", x)
	velocity.y = -500
	velocity.x = x

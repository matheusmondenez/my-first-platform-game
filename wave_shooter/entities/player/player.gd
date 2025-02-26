extends Polygon2D

#region preload_scenes
var PROJECTILE_TSCN: PackedScene = preload("res://wave_shooter/entities/projectile/projectile.tscn")
var PIERCE_SHOT_TSCN: PackedScene = preload("res://wave_shooter/entities/player/pierce_shot.tscn")
var EXPLOSION_TSCN: PackedScene = preload("res://wave_shooter/fx/explosion.tscn")
var SCREEN_DAMAGE_TSCN: PackedScene = preload("res://wave_shooter/ui/screen_damage.tscn")
#endregion

signal life_decreased
signal life_increased

@export var lifes: int = 3:
	set(value):
		var previous_lifes = lifes
		lifes = value
		if lifes < previous_lifes:
			emit_signal("life_decreased")
		elif lifes > previous_lifes:
			emit_signal("life_increased")
var level: int = 1
var xp: int = 0
var direction: Vector2 = Vector2.ZERO
var speed: int = 250
var dash_speed: int = speed * 50
var is_loaded: bool = true
var is_dead: bool = false
#var power_ups: Array = []

#region life_cicle
func _ready() -> void:
	Global.player = self

#region _process
func _process(delta: float) -> void:
	if not is_dead:
		handle_spotlight(delta)
		move(delta)
	if Global.parent_node_creation and is_loaded and not is_dead:
		if not Configs.game_configs.auto_shot and Input.is_action_pressed("shoot"):
			shoot()
		elif Configs.game_configs.auto_shot:
			shoot()
	if Input.is_action_just_pressed("dash"):
		dash(delta)
#endregion

func _exit_tree() -> void:
	Global.player = null
#endregion

func _on_timer_timeout() -> void:
	is_loaded = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.get_parent().get_meta("origin") == "enemy_shot":
		var enemy = area.get_parent() # Pode ser um inimigo ou um tiro de inimigo
		enemy.queue_free()
		take_damage(1, enemy.direction)
		if lifes <= 0:
			die()

func move(delta) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	#global_position = Vector2(clamp(global_position.x, 25, 1895), clamp(global_position.y, 25, 1055))
	global_position += speed * direction * delta

func dash(delta) -> void:
	$Area.monitoring = false
	$Trail.visible = true
	create_tween().tween_property(self, "global_position", global_position + dash_speed * direction * delta, 0.1).finished.connect(func(): $Area.monitoring = true)
	await get_tree().create_timer(0.5).timeout
	$Trail.visible = false

func shoot() -> void:
	var projectile = PROJECTILE_TSCN # PROJECTILE_TSCN # PIERCE_SHOT_TSCN
	Global.instance_node(projectile, global_position, Global.parent_node_creation)
	#if power_ups.has("triple_shot"):
		#var left_shot = Global.instance_node(shot, global_position, Global.parent_node_creation)
		#left_shot.angle = 345
		#var right_shot = Global.instance_node(shot, global_position, Global.parent_node_creation)
		#right_shot.angle = -345
	is_loaded = false
	$Timer.start()

func take_damage(damage: int, knokback: Vector2 = Vector2.ZERO) -> void:
	knockback(knokback, 5) # Implementar a força de acordo com a speed e/ou peso do inimigo
	Global.camera.shake_screen(100, 0.2)
	var screen_damage = Global.instance_node(SCREEN_DAMAGE_TSCN, Vector2(576, 324), Global.camera)
	screen_damage.modulate = Color("4a5fdd")
	lifes -= damage

func knockback(direction: Vector2, force: float) -> void:
	direction = direction.normalized() * force
	create_tween().tween_property(self, "global_position", global_position + force * direction, 0.3)
	#global_position += force * direction

func handle_spotlight(delta) -> void:
	var spotlight: PointLight2D = $Border/Spotlight
	var clamp_range = 25
	var mouse_global: Vector2 = get_global_mouse_position()
	var mouse_local: Vector2 = to_local(mouse_global)
	var edge_position = Vector2.ZERO
	if mouse_local == Vector2.ZERO:
		spotlight.position = Vector2(clamp_range, 0)
		edge_position = Vector2(clamp_range, 0)
	else:
		var max_component = max(abs(mouse_local.x), abs(mouse_local.y))
		edge_position = mouse_local * (clamp_range / max_component)
		spotlight.position = spotlight.position.lerp(edge_position, 10 * delta)

func die() -> void:
	$Area.monitoring = false
	$Area.monitorable = false
	is_dead = true
	visible = false
	var explosion = Global.instance_node(EXPLOSION_TSCN, global_position, Global.parent_node_creation)
	explosion.modulate = Color("4a5fdd")
	await Global.slow_time(0.2, 3)
	get_tree().reload_current_scene()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("skill_1"):
		use_skill(0)
	if event.is_action_pressed("skill_2"):
		use_skill(1)
	if event.is_action_pressed("skill_3"):
		use_skill(2)
	if event.is_action_pressed("skill_4"):
		use_skill(3)

func use_skill(key: int) -> void:
	if not SkillManager.assigned.is_empty() && SkillManager.assigned[key]:
		var skill_props = SkillManager.assigned[key]["resource"]
		if not skill_props.is_cooling:
			skill_props.is_cooling = true
			var skill = SkillManager.assigned[key]["scene"].instantiate()
			skill.global_position = global_position
			Global.parent_node_creation.add_child(skill)
			await get_tree().create_timer(skill_props.cooldown).timeout
			skill_props.is_cooling = false

extends Node2D

@onready var Map: TileMapLayer = $TileMapLayer
var Player = preload("res://wave_shooter/entities/player/player.tscn")
var Room = preload("res://wave_shooter/teste.tscn")
var font = preload("res://wave_shooter/assets/fonts/MonomaniacOne-Regular.ttf")
var tile_size = 16
var num_rooms = 50
var min_size = 4
var max_size = 10
var hspread = 400
var cull = 0.5

var path: AStar2D
var start_room = null
var end_room = null
var play_mode = false
var player = null

func _ready():
	randomize()
	make_rooms()

func make_rooms():
	for i in range(num_rooms):
		#var pos = Vector2(randi_range(-hspread, hspread), 0) # Vector2.ZERO -> Pode deixar ZERO se não for necessário horizontalizar o mapa
		var pos = Vector2.ZERO
		var r = Room.instantiate()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * tile_size)
		$Rooms.add_child(r)
	await  get_tree().create_timer(1.1).timeout
	var room_positions = []
	for room in $Rooms.get_children():
		if randf() < cull:
			room.queue_free()
		else:
			room.freeze = true
			room_positions.append(room.position)
	await get_tree().process_frame
	path = find_minimum_spanning_tree(room_positions)

func make_map():
	find_start_room()
	find_end_room()
	Map.clear()
	var full_rect = Rect2()
	for room in $Rooms.get_children():
		var r = Rect2(room.position - room.size, room.get_node("Shape").shape.extents * 2)
		full_rect = full_rect.merge(r)
	var topleft = Map.local_to_map(full_rect.position)
	var bottomright = Map.local_to_map(full_rect.end)
	for x in range(topleft.x, bottomright.x):
		for y in range(topleft.y, bottomright.y):
			Map.set_cell(Vector2i(x, y), 1, Vector2i(13, 3), 0)
	var corridors = []
	for room in $Rooms.get_children():
		var s = (room.size/tile_size).floor()
		var pos = Map.local_to_map(room.position)
		var ul = (room.position/tile_size).floor() - s # upper left
		for x in range(2, s.x * 2 - 1):
			for y in range(2, s.y * 2 - 1):
				Map.set_cell(Vector2i(ul.x + x, ul.y + y), 1, Vector2i(3, 1), 0)
		var p = path.get_closest_point(room.position)
		for conn in path.get_point_connections(p):
			if not conn in corridors:
				var start = Map.local_to_map(Vector2(path.get_point_position(p).x, path.get_point_position(p).y))
				var end = Map.local_to_map(Vector2(path.get_point_position(conn).x, path.get_point_position(conn).y))
				carve_path(start, end)
		corridors.append(p)

func carve_path(pos1, pos2):
	var x_diff = sign(pos2.x - pos1.x)
	var y_diff = sign(pos2.y - pos1.y)
	if x_diff == 0:
		x_diff = pow(-1, randi() % 2)
	if y_diff == 0:
		y_diff = pow(-1, randi() % 2)
	var x_y = pos1
	var y_x = pos2
	if (randi() % 2) > 0:
		x_y = pos2
		y_x = pos1
	for x in range(pos1.x, pos2.x, x_diff):
		await get_tree().process_frame
		Map.set_cell(Vector2i(x, x_y.y), 1, Vector2i(3, 1))
		Map.set_cell(Vector2i(x, x_y.y + y_diff), 1, Vector2i(3, 1)) # Aumenta a largura do corredor
	await get_tree().create_timer(2).timeout
	for y in range(pos1.y, pos2.y, y_diff):
		await get_tree().process_frame
		Map.set_cell(Vector2i(y_x.x, y), 1, Vector2i(3, 1))
		Map.set_cell(Vector2i(y_x.x + x_diff, y), 1, Vector2i(3, 1)) # Aumenta a largura do corredor

func _draw():
	if start_room:
		draw_string(font, start_room.position, "START")
	if end_room:
		draw_string(font, end_room.position, "END")
	if play_mode:
		return
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2), Color(32, 228, 0), false)
	if path:
		for p in path.get_point_ids():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cp = path.get_point_position(c)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y), Color(1, 1, 0), 1, true)

func _process(delta: float):
	queue_redraw()

func _input(event: InputEvent):
	if event.is_action_pressed("jump"):
		if play_mode:
			player.queue_free()
			play_mode = false
		for n in $Rooms.get_children():
			n.queue_free()
		path = null
		start_room = null
		end_room = null
		make_rooms()
	if event.is_action_pressed("shoot"):
		make_map()
	if event.is_action_pressed("pause"):
		player = Player.instantiate()
		add_child(player)
		player.position = start_room.position
		play_mode = true

func find_minimum_spanning_tree(nodes):
	var path = AStar2D.new()
	path.add_point(path.get_available_point_id(), nodes.pop_front())
	while nodes:
		var min_dist = INF
		var min_p = null
		var p = null
		for point_id in path.get_point_ids():
			var p1 = path.get_point_position(point_id)
			for p2 in nodes:
				if p1.distance_to(p2) < min_dist:
					min_dist = p1.distance_to(p2)
					min_p = p2
					p = p1
		var n = path.get_available_point_id()
		path.add_point(n, min_p)
		path.connect_points(path.get_closest_point(p), n)
		nodes.erase(min_p)
	return path

func find_start_room():
	var min_x = INF
	for room in $Rooms.get_children():
		if room.position.x < min_x:
			start_room = room
			min_x = room.position.x

func find_end_room():
	var max_x = -INF
	for room in $Rooms.get_children():
		if room.position.x > max_x:
			end_room = room
			max_x = room.position.x

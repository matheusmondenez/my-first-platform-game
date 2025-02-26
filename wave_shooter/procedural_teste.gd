extends Node2D

@onready var Map: TileMapLayer = $TileMapLayer

var Room = preload("res://wave_shooter/teste.tscn")
var tile_size = 32
var num_rooms = 50
var min_size = 4
var max_size = 10
var hspread = 400
var cull = 0.5

var path

func _ready():
	randomize()
	make_rooms()

func make_rooms():
	for i in range(num_rooms):
		var pos = Vector2(randi_range(-hspread, hspread), 0) # Vector2.ZERO -> Pode deixar ZERO se não for necessário horizontalizar o mapa
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

func _draw():
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2), Color(32, 228, 0), false)
	if path:
		for p in path.get_point_ids():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cp = path.get_point_position(c)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y), Color(1, 1, 0), 15, true)

func _process(delta: float):
	queue_redraw()

func _input(event: InputEvent):
	if event.is_action_pressed("jump"):
		for n in $Rooms.get_children():
			n.queue_free()
		make_rooms()
	if event.is_action_pressed("shoot"):
		make_map()

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

extends Node2D

onready var size = get_viewport_rect().size

func place_rooms():
	for y in 3:
		for x in 3:
			var room = generate_random_room(x, y).room.instance()
			room.position = Vector2(x * size.x, y * (size.y - 20))
			add_child(room)

func generate_random_room(x, y):
	randomize()
	var rooms = Global.Rooms
	
	var filtered_group = "lr"
	match [x, y]:
		[0, 0] : filtered_group = "r"
		[1, 0], [1, 1], [1,2] : filtered_group = "lr"
		[2, 0] : filtered_group = "ld"
		[0, 1] : filtered_group = "rd"
		[0, 2] : filtered_group = "ru"
		[2, 1] : filtered_group = "lu"
		[2, 2] : filtered_group = "l"
	
	
	var random_room = rooms[randi() % rooms.size()]
	while random_room.group != filtered_group:
		random_room = rooms[randi() % rooms.size()]
	
	#print(filtered_groups.sort())
	
	return random_room

func _ready():
	place_rooms()

extends Node2D

onready var tm: TileMap = get_parent().get_node("CaveTileMap")
export var width := 90
export var height := 90
export var platform_tries := 1000
export var platform_width := 90 * 0.7
export var gap_principal_platforms := 10

func _ready():
	add_border(width, height)
	add_central_platforms(width, height, gap_principal_platforms)
	for i in platform_tries:
		add_platform(width, height)

func add_border(w, h):
	for i in w:
		sc(i,0,0)
		sc(i,h,0)
	for i in h:
		sc(0,i,0)
		sc(w,i,0)
	sc(w,h,0)

func add_central_platforms(w, h, gap):
	randomize()
	var direction := true
	for column in height:
		if column % gap == 0:
			var random_x := randi() % int(platform_width / 2)
			var random_y := randi() % 1 + 1
			direction = !direction
			for row in platform_width:
				var x: int = row - random_x if direction else width - row + random_x
				if x < 1: x = 1
				if x > width - 1: x = width - 1
				
				var y: int = column - random_y
				if y < 0: y = 0
				
				for i in 3:
					sc(x, y + i, 0)

func add_platform(w, h):
	var can_place := true
	var random_x: int = randi() % w
	var random_y: int = randi() % h
	
	var random_cell = tm.get_cell(random_x, random_y)
	
	for column in range(random_y - 5, random_y + 5):
		for row in range(random_x - 7, random_x + 7):
			if tm.get_cell(row, column) != -1:
				can_place = false
	
	if can_place:
		for i in (randi() % 5 + 5):
			sc(random_x + i, random_y, 0)
			sc(random_x + i, random_y + 1, 0)

func sc(x,y,index):
	tm.set_cell(x,y,index)

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

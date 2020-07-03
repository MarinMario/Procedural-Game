extends Node2D

onready var tm = $CaveTileMap
var width := 90
var height := 90

func _ready():
	add_border(width, height)
	add_central_platforms(width, height, 10)
	for i in 1000:
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
			var platform_width := width * 0.7
			var random_x := randi() % int(platform_width / 2)
			var random_y := randi() % 1 + 1
			direction = !direction
			for row in platform_width:
				var x: int = row - random_x if direction else width - row + random_x
				if x < 1: x = 1
				if x > width - 1: x = width - 1
				
				var y: int = column - random_y
				if y < 0: y = 0
				
				sc(x, y, 0)
				sc(x, y + 1, 1)

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
			sc(random_x + i, random_y + 1, 1)

func sc(x,y,index):
	tm.set_cell(x,y,index)

func remove_cell(cell_position):
	tm.set_cellv(cell_position, -1)

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

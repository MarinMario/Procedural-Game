extends Node2D

onready var tm: TileMap = get_parent().get_node("CaveTileMap")
export var width = 200
export var height = 120
export var tile_size = 2

func _ready():
	create_block(width, height)
	random_walk(width, height, width * height, tile_size)
	add_grass(width, height)

func create_block(w, h):
	for x in w:
		for y in h:
			tm.set_cell(x, y, 0)

func random_walk(w, h, tile_amount, tile_size):
	var tiles_to_remove := [random_cell(w, h)]
	for tile in tile_amount:
		var next_tile: Vector2 = tiles_to_remove[tile] + random_dir()
		if next_tile.x > w or next_tile.x < 0 or next_tile.y > h or next_tile.y < 0:
			next_tile = random_cell(w, h)
			
		tiles_to_remove.append(next_tile)
	
	for tile in tiles_to_remove:
		for i in tile_size:
			for j in tile_size:
				tm.set_cell(tile.x + i, tile.y + j, -1)

func random_dir():
	randomize()
	var dir := Vector2(int(rand_range(-2,2)), int(rand_range(-2,2)))
	return dir

func random_cell(w, h):
	randomize()
	var cell := Vector2(randi() % w, randi() % h)
	return cell

func add_grass(w, h):
	for x in w:
		for y in h:
			if tm.get_cell(x, y) == 0 and tm.get_cell(x, y - 1) == -1:
				tm.set_cell(x, y, 1)
				












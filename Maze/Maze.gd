extends Spatial

const N = 1 					# binary 0001
const E = 2 					# binary 0010
const S = 4 					# binary 0100
const W = 8 					# binary 1000

onready var MiniMap = get_node_or_null("/root/Game/UI/VP/Map_Container/MiniMap")

var cell_walls = {
	Vector2(0, -1): N, 			# cardinal directions for NESW
	Vector2(1, 0): E,
	Vector2(0, 1): S, 
	Vector2(-1, 0): W
}

var map = []

var tiles = [
	preload("res://Maze/Tile0.tscn")	# all the tiles we created
	,preload("res://Maze/Tile1.tscn")
	,preload("res://Maze/Tile2.tscn")
	,preload("res://Maze/Tile3.tscn")
	,preload("res://Maze/Tile4.tscn")
	,preload("res://Maze/Tile5.tscn")
	,preload("res://Maze/Tile6.tscn")
	,preload("res://Maze/Tile7.tscn")
	,preload("res://Maze/Tile8.tscn")
	,preload("res://Maze/Tile9.tscn")
	,preload("res://Maze/Tile10.tscn")
	,preload("res://Maze/Tile11.tscn")
	,preload("res://Maze/Tile12.tscn")
	,preload("res://Maze/Tile13.tscn")
	,preload("res://Maze/Tile14.tscn")
	,preload("res://Maze/Tile15.tscn")
]

var mini_tiles = [
	preload("res://MiniMap/Tile0.tscn")		# all the mini map tiles
	,preload("res://MiniMap/Tile1.tscn")
	,preload("res://MiniMap/Tile2.tscn")
	,preload("res://MiniMap/Tile3.tscn")
	,preload("res://MiniMap/Tile4.tscn")
	,preload("res://MiniMap/Tile5.tscn")
	,preload("res://MiniMap/Tile6.tscn")
	,preload("res://MiniMap/Tile7.tscn")
	,preload("res://MiniMap/Tile8.tscn")
	,preload("res://MiniMap/Tile9.tscn")
	,preload("res://MiniMap/Tile10.tscn")
	,preload("res://MiniMap/Tile11.tscn")
	,preload("res://MiniMap/Tile12.tscn")
	,preload("res://MiniMap/Tile13.tscn")
	,preload("res://MiniMap/Tile14.tscn")
	,preload("res://MiniMap/Tile15.tscn")
]

var tile_size = 2 						# 2-meter tiles
var mini_tile_size = 32
var width = 20  						# width of map (in tiles) x
var height = 10  						# height of map (in tiles) z

onready var Key = preload("res://Key/Key.tscn")
onready var Exit = preload("res://Exit/Exit.tscn")

func _ready():
	randomize()
	make_maze()
	var key = Key.instance()
	key.translate(Vector3((width*tile_size)-2.0,0.3,-.5))
	add_child(key)
	#print(key.global_transform.origin)
	var exit = Exit.instance()
	exit.translate(Vector3((width*tile_size)-2.0,0.0,(height*tile_size)-1.2))
	add_child(exit)
	#print(exit.global_transform.origin)
	
func check_neighbors(cell, unvisited):
	# returns an array of cell's unvisited neighbors
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
func make_maze():
	var unvisited = []  # array of unvisited tiles
	var stack = []
	# fill the map with solid tiles
	for x in range(width):
		map.append([])
		map[x].resize(height)
		for y in range(height):
			unvisited.append(Vector2(x, y))
			map[x][y] = N|E|S|W 		# 15
	var current = Vector2(0, 0)
	unvisited.erase(current)
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			var dir = next - current
			var current_walls = map[current.x][current.y] - cell_walls[dir]
			var next_walls = map[next.x][next.y] - cell_walls[-dir]
			map[current.x][current.y] = current_walls
			map[next.x][next.y] = next_walls
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
	for x in range(width):
		for z in range(height):
			var tile = tiles[map[x][z]].instance()
			tile.translation = Vector3(x*tile_size,0,z*tile_size)
			tile.name = "Tile_" + str(x) + "_" + str(z)
			add_child(tile)
			var tile2 = mini_tiles[map[x][z]].instance()
			tile2.position = Vector2(x,z)*mini_tile_size
			tile2.name = "MTile_" + str(x) + "_" + str(z)
			MiniMap.add_child(tile2)

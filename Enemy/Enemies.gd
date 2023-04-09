extends Spatial

onready var Enemy = preload("res://Enemy/Enemy.tscn")
onready var Maze = get_node("/root/Game/Maze")
onready var Nme = load("res://Assets/nme.png")
onready var MiniMap = get_node_or_null("/root/Game/UI/VP/Map_Container/MiniMap")

export var count = 15

func _ready():
	var locations = []
	for x in range(Maze.width):
		for z in range(Maze.height):
			locations.append(Vector3(((x+1)*Maze.tile_size)-2,0.1,((z+1)*Maze.tile_size)-2))
	locations.shuffle()
	for i in range(count):
		var enemy = Enemy.instance()
		enemy.translate(locations[i])
		add_child(enemy)

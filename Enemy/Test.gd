extends Spatial

onready var Mushroom = load("res://Enemy/Enemy.tscn")
var spawn = Vector3(10,0,-5)

func _ready():
	pass

func _physics_process(_delta):
	if not has_node("Mushroom"):
		var mushroom = Mushroom.instance()
		mushroom.translation = spawn
		mushroom.name = "Mushroom"
		add_child(mushroom)

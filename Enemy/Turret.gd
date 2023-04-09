extends StaticBody

onready var head = $Spatial/Head
onready var rc = $RayCast
onready var Attack = load("res://Enemy/Bullet.tscn")

var health = 50
var Player = null

func _ready():
	pass

func _physics_process(_delta):
	Player = get_node_or_null("/root/Game/Player")
	if Player != null:
		#head.look_at(Player.global_transform.origin,Vector3.UP)
		rc.cast_to = to_local(Player.global_transform.origin)
		var r = rc.get_collider()
		if r.name == "Player":
			var attack = Attack.instance()
			head.add_child(attack)
			attack.look_at(rc.get_collision_point(),Vector3.UP)

func Hit(d):
	health -= d
	if health <= 0:
		Global.update_score(250)
		queue_free()

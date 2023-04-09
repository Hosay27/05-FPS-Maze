extends KinematicBody

var Player = null
var health = 12
var damage = 1

onready var effect = $Spatial/mushroom/AnimationPlayer

func _ready():
	#effect.play("Idle")
	pass

func _physics_process(_delta):
	Player = get_node_or_null("/root/Game/Player")
	if Player != null:
		look_at(Player.global_transform.origin,Vector3.UP)
	effect.play("Idle")
	#print(health)
	#pass

func Hit(d):
	health -= d
	if health <= 0:
		Global.update_score(50)
		queue_free()

func _on_Kill_body_entered(body):
	if body.name == "Player":
		body.Hit(damage)

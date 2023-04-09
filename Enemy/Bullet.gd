extends RigidBody

var speed = 5
var damage = 1

func _ready():
	pass

func _physics_process(_delta):
	apply_impulse(transform.basis.z,-transform.basis.z)

func _on_Area_body_entered(body):
	if body.name == "Player":
		body.Hit(damage)
		queue_free()
	else:
		queue_free()

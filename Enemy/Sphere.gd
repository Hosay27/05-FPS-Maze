extends Spatial


func _ready():
	pass

func _physics_process(_delta):
	rotation_degrees.y += 5

func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		body.Hit(1)

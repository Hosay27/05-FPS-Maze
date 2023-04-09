extends StaticBody


func _ready():
	pass

func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		body.Hit(1)

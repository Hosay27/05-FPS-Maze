extends Area

export var color = "Red"


func _on_Red_Key_body_entered(body):
	if body.name == "Player":
		body.keys.append(color)
		var collect = get_node_or_null("/root/Game/Key_Collect")
		if collect != null:
			collect.play()
		queue_free()

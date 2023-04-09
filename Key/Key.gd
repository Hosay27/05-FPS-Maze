extends Area


func _ready():
	pass


func _on_Key_body_entered(body):
	if body.name == "Player":
		var collect = get_node_or_null("/root/Game/Key_Collect")
		if collect != null:
			collect.play()
		var exit = get_node_or_null("/root/Game/Maze/Exit")
		if exit != null:
			exit.unlock()
			queue_free()
		var exit2 = get_node_or_null("/root/Game/Maze/Exit2")
		if exit2 != null:
			exit2.unlock()
			queue_free()

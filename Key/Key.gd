extends Area


func _ready():
	pass


func _on_Key_body_entered(body):
	if body.name == "Player":
		#print("collect")
		var exit = get_node_or_null("/root/Game/Maze/Exit")
		print(exit)
		if exit != null:
			exit.unlock()
			queue_free()

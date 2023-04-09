extends StaticBody

onready var DoorOpen = load("res://Exit/Red_Open.tscn")

export var color = "Red"

func _on_Unlock_body_entered(body):
	if body.name == "Player":
		if color in body.keys:
			var open = get_node_or_null("/root/Game/Door")
			if open != null:
				open.play()
			var dooropen = DoorOpen.instance()
			dooropen.global_transform.origin = global_transform.origin
			var Maze = get_node_or_null("/root/Game/Maze")
			if Maze != null:
				Maze.add_child(dooropen)
			queue_free()

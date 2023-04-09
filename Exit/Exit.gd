extends Area

var locked = true

func _ready():
	$Light.light_color = Color(1,0,0,1)

func unlock():
	locked = false
	$Light.light_color = Color(0,1,0,1)

func _on_Exit_body_entered(body):
	if body.name == "Player" and locked == false:
		if name == "Exit":
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Global.update_score(100)
			Global.update_level(1)
			var open = get_node_or_null("/root/Game/Door")
			if open != null:
				open.play()
			var _scene = get_tree().change_scene("res://Levels/Level2.tscn")
		if name == "Exit2":
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Global.update_score(150)
			var _scene = get_tree().change_scene("res://UI/Win.tscn")
			#var _scene = get_tree().change_scene("res://Levels/Level3.tscn")

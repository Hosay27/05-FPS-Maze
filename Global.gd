extends Node

var menu = null
var health = 15
var score = 0
var level = 1

func _ready():
	randomize()
	pause_mode = Node.PAUSE_MODE_PROCESS

func update_health(h):
	health -= h

func update_score(s):
	score += s

func update_level(l):
	level += l

func reset():
	health = 10
	score = 0
	level = 1

func _unhandled_input(_event):
	if Input.is_action_just_pressed("menu"):
		if menu == null:
			menu = get_node_or_null("/root/Game/UI/Menu")
		if menu != null:
			if menu.visible:
				menu.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				get_tree().paused = false
			else:
				menu.show()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				get_tree().paused = true
	if Input.is_action_just_pressed("inventory"):
		var Inventory = get_node_or_null("/root/Game/UI/HUD/Inventory")
		if Inventory != null:
			if Inventory.visible:
				get_tree().paused = false
				Inventory.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				Inventory.show()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				get_tree().paused = true

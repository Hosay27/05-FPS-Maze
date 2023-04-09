extends KinematicBody

onready var Camera = $Pivot/Camera
onready var Guns = get_node_or_null("/root/Game/Guns")
onready var text = get_node_or_null("/root/Game/UI/HUD/Pickup")
onready var Inventory = get_node("/root/Game/UI/HUD/Inventory")

var keys = []

var gravity = -30
var max_speed = 5
var mouse_sensitivity = 0.02
var mouse_range = 1.2
var damage = 1

var to_pickup = null
var velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	if Global.level == 2:
		max_speed = 8
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("pickup"):
		pickup()
	if Input.is_action_just_pressed("swap"):
		swap()

func pickup():
	var gun = get_node_or_null("Pivot/Gun")
	if gun != null and to_pickup != null:
		gun = to_pickup.Pickup.instance()
		gun.name = "Gun"
		$Inventory.add_child(gun)
		Inventory.update_inventory($Inventory.get_children())
		to_pickup.queue_free()
	elif gun != null:
		var to_drop = gun.Pickup.instance()
		Guns.add_child(to_drop)
		to_drop.global_transform.origin = global_transform.origin + Vector3(0,1.5,0)
		var throw = Vector3.ZERO
		throw += -Camera.global_transform.basis.z * 8.0
		throw += -Camera.global_transform.basis.y * 0.5
		to_drop.apply_central_impulse(throw)
		gun.queue_free()
		Inventory.update_selection(null)
	elif to_pickup != null:
		#print("start2")
		gun = to_pickup.Pickup.instance()
		gun.name = "Gun"
		$Pivot.add_child(gun)
		Inventory.update_selection(gun.inventory)
		to_pickup.queue_free()


func swap():
	var gun1 = get_node_or_null("Pivot/Gun")
	var inventory = get_node_or_null("Inventory")
	if gun1 != null and inventory != null and inventory.get_child_count() > 0:
		var gun2 = inventory.get_child(0)
		$Pivot.remove_child(gun1)
		$Inventory.remove_child(gun2)
		$Pivot.add_child(gun2)
		gun2.name = "Gun"
		Inventory.update_selection(gun2.inventory)
		$Inventory.add_child(gun1)
		Inventory.update_inventory($Inventory.get_children())

func swap_inventory(gun2):
	var gun1 = get_node_or_null("Pivot/Gun")
	var inventory = get_node_or_null("Inventory")
	if gun1 != null and inventory != null and inventory.get_child_count() > 0:
		$Pivot.remove_child(gun1)
		$Inventory.remove_child(gun2)
		$Pivot.add_child(gun2)
		gun2.name = "Gun"
		Inventory.update_selection(gun2.inventory)
		$Inventory.add_child(gun1)
		Inventory.update_inventory($Inventory.get_children())

func shoot():
	var gun = get_node_or_null("Pivot/Gun")
	if gun != null:
		gun.shoot()

func Hit(d):
	if $Invincible.is_stopped():
		$Invincible.start()
		Global.update_health(d)
		if Global.health <= 0:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			var _scene = get_tree().change_scene("res://UI/Lose.tscn")

func _on_Area_body_entered(body):
	if body.is_in_group("Guns"):
		text.text = "Press E to pickup"
		text.show()
		to_pickup = body

func _on_Area_body_exited(_body):
	text.hide()
	to_pickup = null

extends Spatial

onready var flash = $Flash
onready var Decal = preload("res://Player/Decal.tscn")
onready var Pickup = load("res://Guns/shotgun.tscn")
onready var inventory = load("res://Assets/shotgun.png")
onready var inventory1 = load("res://Assets/shotgun_hover.png")
onready var ray = $Raycasts
onready var effect = $AnimationPlayer

var ready = true
var damage = 1
var spread = 6

func _ready():
	for r in ray.get_children():
			r.cast_to.x = rand_range(spread,-spread)
			r.cast_to.y = rand_range(spread,-spread)

func shoot():
	if ready:
		flash.shoot()
		ready = false
		$Timer.start()
		effect.play("shoot")
		var shoot = get_node_or_null("/root/Game/Shotgun")
		if shoot != null:
			shoot.play()
		for r in ray.get_children():
			r.force_raycast_update()
			r.cast_to.x = rand_range(spread,-spread)
			r.cast_to.y = rand_range(spread,-spread)
			if r.is_colliding():
				var c = r.get_collider()
				var decal = Decal.instance()
				r.get_collider().add_child(decal)
				decal.global_transform.origin = r.get_collision_point()
				decal.look_at(r.get_collision_point() + r.get_collision_normal(), Vector3.UP)
				if c.is_in_group("enemy"):
					if c.has_method("Hit"):
						c.Hit(damage)

func _on_Timer_timeout():
	ready = true

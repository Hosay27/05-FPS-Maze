extends Spatial

onready var sight = $Sight
onready var flash = $Flash
onready var Decal = preload("res://Player/Decal.tscn")
onready var Pickup = load("res://Guns/pistol.tscn")
onready var inventory = load("res://Assets/pistol.png")
onready var inventory1 = load("res://Assets/pistol_hover.png")
onready var animation_player = $AnimationPlayer

var ready = true
var damage = 4

func shoot():
	if ready:
		ready = false
		$Timer.start()
		flash.shoot()
		var shoot = get_node_or_null("/root/Game/Pistol")
		if shoot != null:
			shoot.play()
		animation_player.play("shoot")
		if sight.is_colliding():
			var c = sight.get_collider()
			var decal = Decal.instance()
			sight.get_collider().add_child(decal)
			decal.global_transform.origin = sight.get_collision_point()
			decal.look_at(sight.get_collision_point() + sight.get_collision_normal(), Vector3.UP)
			if c.is_in_group("enemy"):
				if c.has_method("Hit"):
					c.Hit(damage)


func _on_Timer_timeout():
	ready = true

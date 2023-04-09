extends Spatial

onready var sight = $Sight
onready var flash = $Flash
onready var Decal = preload("res://Player/Decal.tscn")
onready var Pickup = load("res://Guns/FN P90.tscn")
onready var inventory = load("res://Assets/FN P90.png")
onready var inventory1 = load("res://Assets/FN P90_hover.png")
onready var animation_player = $AnimationPlayer

var damage = 2

func shoot():
	if !flash.visible:
		flash.shoot()
		var shoot = get_node_or_null("/root/Game/Shoot")
		if shoot != null:
			shoot.play()
		animation_player.play("CubeAction")
		if sight.is_colliding():
			var c = sight.get_collider()
			var decal = Decal.instance()
			sight.get_collider().add_child(decal)
			decal.global_transform.origin = sight.get_collision_point()
			decal.look_at(sight.get_collision_point() + sight.get_collision_normal(), Vector3.UP)
			if c.is_in_group("enemy"):
				if c.has_method("Hit"):
					c.Hit(damage)

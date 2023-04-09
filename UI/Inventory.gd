extends Control

var weapon_refs = []

func _ready():
	var inventory = $Grid.get_children()
	for i in inventory:
		i.texture_normal = null
		i.texture_hover = null
		i.disabled = true

func update_selection(t):
	$Selection.texture = t


func update_inventory(inv):
	weapon_refs = []
	for i in $Grid.get_children():
		i.texture_normal = null
		i.texture_hover = null
		i.disabled = true
	var count = 0
	for i in inv:
		$Grid.get_child(count).texture_normal = i.inventory
		$Grid.get_child(count).texture_hover = i.inventory1
		$Grid.get_child(count).disabled = false
		#print("disabled")
		weapon_refs.append(i)
		count += 1

func _on_Inv1_pressed():
	print("push")
	var Player = get_node_or_null("/root/Game/Player")
	if Player != null and weapon_refs.size() >= 0:
		Player.swap_inventory(weapon_refs[0])

func _on_Inv2_pressed():
	var Player = get_node_or_null("/root/Game/Player")
	if Player != null and weapon_refs.size() >= 1:
		Player.swap_inventory(weapon_refs[1])

func _on_Inv3_pressed():
	var Player = get_node_or_null("/root/Game/Player")
	if Player != null and weapon_refs.size() >= 2:
		Player.swap_inventory(weapon_refs[2])

func _on_Inv4_pressed():
	var Player = get_node_or_null("/root/Game/Player")
	if Player != null and weapon_refs.size() >= 3:
		Player.swap_inventory(weapon_refs[3])

func _on_Inv5_pressed():
	var Player = get_node_or_null("/root/Game/Player")
	if Player != null and weapon_refs.size() >= 4:
		Player.swap_inventory(weapon_refs[4])

func _on_Inv6_pressed():
	var Player = get_node_or_null("/root/Game/Player")
	if Player != null and weapon_refs.size() >= 5:
		Player.swap_inventory(weapon_refs[5])

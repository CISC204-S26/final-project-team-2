#I might scrap this bc this method is kinda mid. - mike

extends Node2D

@export var portal_scene: PackedScene

var portals: Array = []  # stores the two placed portals
var max_portals: int = 2

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			place_portal(get_global_mouse_position())

func place_portal(pos: Vector2):
	# If we already have 2 portals, remove the oldest one
	if portals.size() >= max_portals:
		portals[0].queue_free()
		portals.remove_at(0)
	
	# Spawn new portal
	var portal = portal_scene.instantiate()
	get_tree().get_root().add_child(portal)
	portal.global_position = pos
	portals.append(portal)
	
	# If we now have 2, link them together
	if portals.size() == 2:
		portals[0].link_to(portals[1])
		portals[1].link_to(portals[0])
		print("PORTALS LINKED")

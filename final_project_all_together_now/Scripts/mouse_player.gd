extends Node2D

var entry_portal_scene: PackedScene = preload("res://Scenes/EntryPortal.tscn")
var exit_portal_scene: PackedScene = preload("res://Scenes/ExitPortal.tscn")

var entry_portal: Portal = null
var exit_portal: Portal = null

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			place_entry_portal(get_global_mouse_position())
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			place_exit_portal(get_global_mouse_position())

func place_entry_portal(pos: Vector2):
	if _is_in_no_portal_zone(pos):
		print("Cannot place entry portal here — blocked zone!")
		return
	if entry_portal:
		# Play close animation then free
		entry_portal.close()
		await entry_portal.anim.animation_finished
		entry_portal.queue_free()
	entry_portal = entry_portal_scene.instantiate()
	get_tree().get_root().add_child(entry_portal)
	entry_portal.global_position = pos
	print("ENTRY PORTAL PLACED AT: ", pos)
	_try_link_portals()

func place_exit_portal(pos: Vector2):
	if _is_in_no_portal_zone(pos):
		print("Cannot place exit portal here — blocked zone!")
		return
	if exit_portal:
		# Play close animation then free
		exit_portal.close()
		await exit_portal.anim.animation_finished
		exit_portal.queue_free()
	exit_portal = exit_portal_scene.instantiate()
	get_tree().get_root().add_child(exit_portal)
	exit_portal.global_position = pos
	print("EXIT PORTAL PLACED AT: ", pos)
	_try_link_portals()

func _try_link_portals():
	if entry_portal and exit_portal:
		entry_portal.linked_portal = exit_portal
		print("Portals linked!")

func _is_in_no_portal_zone(pos: Vector2) -> bool:
	var zones = get_tree().get_nodes_in_group("no_portal_zone")
	for zone in zones:
		if zone.has_method("contains_point"):
			if zone.contains_point(pos):
				return true
	return false

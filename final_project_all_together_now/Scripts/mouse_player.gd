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
	print("=== ENTRY CLICK AT: ", pos, " ===")
	var blocked = _is_in_no_portal_zone(pos)
	print("IS BLOCKED: ", blocked)
	if blocked:
		print("ENTRY BLOCKED — returning")
		return
	if entry_portal:
		entry_portal.queue_free()
	entry_portal = entry_portal_scene.instantiate()
	get_tree().get_root().add_child(entry_portal)
	entry_portal.global_position = pos
	var rect = ColorRect.new()
	rect.size = Vector2(32, 32)
	rect.color = Color(0, 0.5, 1, 0.8)
	rect.position = Vector2(-16, -16)
	entry_portal.add_child(rect)
	print("ENTRY PORTAL PLACED AT: ", pos)
	_try_link_portals()

func place_exit_portal(pos: Vector2):
	print("=== EXIT CLICK AT: ", pos, " ===")
	var blocked = _is_in_no_portal_zone(pos)
	print("IS BLOCKED: ", blocked)
	if blocked:
		print("EXIT BLOCKED — returning")
		return
	if exit_portal:
		exit_portal.queue_free()
	exit_portal = exit_portal_scene.instantiate()
	get_tree().get_root().add_child(exit_portal)
	exit_portal.global_position = pos
	var rect = ColorRect.new()
	rect.size = Vector2(32, 32)
	rect.color = Color(1, 0.5, 0, 0.8)
	rect.position = Vector2(-16, -16)
	exit_portal.add_child(rect)
	print("EXIT PORTAL PLACED AT: ", pos)
	_try_link_portals()

func _try_link_portals():
	if entry_portal and exit_portal:
		entry_portal.linked_portal = exit_portal
		print("Portals linked!")

func _is_in_no_portal_zone(pos: Vector2) -> bool:
	var zones = get_tree().get_nodes_in_group("no_portal_zone")
	print("  Zones found in group: ", zones.size())
	for zone in zones:
		print("  Checking zone: ", zone.name)
		print("  Has contains_point method: ", zone.has_method("contains_point"))
		if zone.has_method("contains_point"):
			var result = zone.contains_point(pos)
			print("  contains_point result: ", result)
			if result:
				return true
	return false

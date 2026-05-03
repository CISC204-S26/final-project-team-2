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
	if entry_portal:
		entry_portal.queue_free()
	entry_portal = entry_portal_scene.instantiate()
	get_tree().get_root().add_child(entry_portal)
	entry_portal.global_position = pos
	# Blue square so you can see it
	var rect = ColorRect.new()
	rect.size = Vector2(32, 32)
	rect.color = Color(0, 0.5, 1, 0.8)
	rect.position = Vector2(-16, -16)
	entry_portal.add_child(rect)
	print("ENTRY PORTAL PLACED AT: ", pos)
	_try_link_portals()

func place_exit_portal(pos: Vector2):
	if exit_portal:
		exit_portal.queue_free()
	exit_portal = exit_portal_scene.instantiate()
	get_tree().get_root().add_child(exit_portal)
	exit_portal.global_position = pos
	# Orange square so you can see it
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

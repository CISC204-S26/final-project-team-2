extends Node2D

@export var portal_scene: PackedScene

var entry_portal = null
var exit_portal = null

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			place_entry_portal(get_global_mouse_position())
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			place_exit_portal(get_global_mouse_position())

func place_entry_portal(pos: Vector2):
	if entry_portal:
		entry_portal.queue_free()
	
	# Spawn a blue square as placeholder
	entry_portal = ColorRect.new()
	entry_portal.size = Vector2(32, 32)
	entry_portal.color = Color(0, 0.5, 1, 0.8)  # blue
	get_tree().get_root().add_child(entry_portal)
	entry_portal.global_position = pos - Vector2(16, 16)
	print("ENTRY PORTAL PLACED AT: ", pos)

func place_exit_portal(pos: Vector2):
	if exit_portal:
		exit_portal.queue_free()
	
	# Spawn an orange square as placeholder
	exit_portal = ColorRect.new()
	exit_portal.size = Vector2(32, 32)
	exit_portal.color = Color(1, 0.5, 0, 0.8)  # orange
	get_tree().get_root().add_child(exit_portal)
	exit_portal.global_position = pos - Vector2(16, 16)
	print("EXIT PORTAL PLACED AT: ", pos)

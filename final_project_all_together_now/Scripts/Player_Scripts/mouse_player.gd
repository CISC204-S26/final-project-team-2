extends Node2D

var entry_portal_scene: PackedScene = preload("res://Scenes/EntryPortal.tscn")
var exit_portal_scene: PackedScene = preload("res://Scenes/ExitPortal.tscn")

@onready var cursor_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var portal_duration: float = 5.0

var entry_portal: Portal = null
var exit_portal: Portal = null
var portal_timer: Timer = null
var last_mouse_x: float = 0.0

var is_dragging_exit: bool = false
var exit_portal_pos: Vector2 = Vector2.ZERO
var drag_line: Line2D = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	cursor_sprite.play("FairyMouse")

	portal_timer = Timer.new()
	portal_timer.one_shot = true
	portal_timer.timeout.connect(_on_portal_timer_timeout)
	add_child(portal_timer)

	# Set up drag direction line
	drag_line = Line2D.new()
	drag_line.width = 3.0
	drag_line.default_color = Color(1, 0.5, 0, 0.8)
	drag_line.visible = false
	add_child(drag_line)

func _process(delta):
	var mouse_pos = get_global_mouse_position()

	if mouse_pos.x < last_mouse_x:
		cursor_sprite.flip_h = true
	elif mouse_pos.x > last_mouse_x:
		cursor_sprite.flip_h = false

	last_mouse_x = mouse_pos.x
	cursor_sprite.global_position = mouse_pos

	# Update drag arrow while dragging
	if is_dragging_exit:
		drag_line.visible = true
		drag_line.points = [exit_portal_pos, mouse_pos]

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			place_entry_portal(get_global_mouse_position())

		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				# Start drag — place exit portal here
				exit_portal_pos = get_global_mouse_position()
				is_dragging_exit = true
				_begin_place_exit_portal(exit_portal_pos)
			else:
				# Release — set launch direction
				if is_dragging_exit and exit_portal:
					var drag_end = get_global_mouse_position()
					var direction = (drag_end - exit_portal_pos).normalized()
					exit_portal.launch_direction = direction
					print("Launch direction set: ", direction)
				is_dragging_exit = false
				drag_line.visible = false

func place_entry_portal(pos: Vector2):
	if _is_in_no_portal_zone(pos):
		print("Cannot place entry portal here — blocked zone!")
		return
	if entry_portal:
		entry_portal.close()
		await entry_portal.anim.animation_finished
		entry_portal.queue_free()
	entry_portal = entry_portal_scene.instantiate()
	get_tree().get_root().add_child(entry_portal)
	entry_portal.global_position = pos
	print("ENTRY PORTAL PLACED AT: ", pos)
	_try_link_portals()

func _begin_place_exit_portal(pos: Vector2):
	if _is_in_no_portal_zone(pos):
		print("Cannot place exit portal here — blocked zone!")
		return
	if exit_portal:
		exit_portal.close()
		await exit_portal.anim.animation_finished
		exit_portal.queue_free()
	exit_portal = exit_portal_scene.instantiate()
	get_tree().get_root().add_child(exit_portal)
	exit_portal.global_position = pos
	exit_portal.launch_direction = Vector2.UP  # default until drag released
	print("EXIT PORTAL PLACED AT: ", pos)
	_try_link_portals()

func _try_link_portals():
	if entry_portal and exit_portal:
		entry_portal.linked_portal = exit_portal
		exit_portal.linked_portal = entry_portal
		print("Portals linked!")
		portal_timer.stop()
		portal_timer.start(portal_duration)
		print("Portal timer started: ", portal_duration, " seconds")

func _on_portal_timer_timeout():
	print("Portal timer expired — closing both portals!")
	await _close_and_free_portal(entry_portal)
	await _close_and_free_portal(exit_portal)
	entry_portal = null
	exit_portal = null

func _close_and_free_portal(portal: Portal):
	if portal:
		portal.close()
		await portal.anim.animation_finished
		portal.queue_free()

func _is_in_no_portal_zone(pos: Vector2) -> bool:
	var zones = get_tree().get_nodes_in_group("no_portal_zone")
	for zone in zones:
		if zone.has_method("contains_point"):
			if zone.contains_point(pos):
				return true
	return false

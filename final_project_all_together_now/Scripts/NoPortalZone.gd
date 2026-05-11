#extends "res://Scripts/Interactable.gd"

class_name NoPortalZone extends Area2D

@export var zone_size: Vector2 = Vector2(20, 20)

var _is_hovered: bool = false
var _is_flashing: bool = false
var _flash_timer: float = 0.0
var _flash_duration: float = 1.5  # seconds to flash
var _flash_frequency: float = 8.0 # pulses per second

func _ready():
	add_to_group("no_portal_zone")
	for child in get_children():
		if child is CollisionShape2D and child.shape is RectangleShape2D:
			child.shape.size = zone_size
	#print("NoPortalZone ready! global_pos: ", global_position, " size: ", zone_size)

func _process(delta: float):
	# Hover detection
	var mouse_pos = get_global_mouse_position()
	var was_hovered = _is_hovered
	_is_hovered = contains_point(mouse_pos)
	if _is_hovered != was_hovered:
		queue_redraw()
	
	# Flash timer countdown
	if _is_flashing:
		_flash_timer -= delta
		if _flash_timer <= 0.0:
			_is_flashing = false
		queue_redraw()

func flash_blocked():
	_is_flashing = true
	_flash_timer = _flash_duration
	queue_redraw()
	# play blocked alarm sound here
	# $AudioStreamPlayer.play("POP SMOKE")

func contains_point(pos: Vector2) -> bool:
	var local_pos = to_local(pos)
	var half = zone_size / 2
	return (
		local_pos.x >= -half.x and local_pos.x <= half.x and
		local_pos.y >= -half.y and local_pos.y <= half.y
	)

func _draw():
	var half = zone_size / 2
	var fill_alpha := 0.3
	var outline_alpha := 0.8

	if _is_flashing:
		# im ngl i lowkey looked this part up so dont ask what any of this does
		var pulse = (sin(_flash_timer * _flash_frequency * TAU) + 1.0) / 2.0
		fill_alpha = lerp(0.15, 0.7, pulse)
		outline_alpha = lerp(0.6, 1.0, pulse)
	elif _is_hovered:
		fill_alpha = 0.5
		outline_alpha = 1.0
	draw_rect(Rect2(-half, zone_size), Color(1, 0, 0, fill_alpha), true)
	draw_rect(Rect2(-half, zone_size), Color(1, 0, 0, outline_alpha), false)

#extends "res://Scripts/Interactable.gd"

class_name NoPortalZone extends Area2D

@export var zone_size: Vector2 = Vector2(20, 20)


func _ready():
	add_to_group("no_portal_zone")
	for child in get_children():
		if child is CollisionShape2D and child.shape is RectangleShape2D:
			child.shape.size = zone_size
	print("NoPortalZone ready! global_pos: ", global_position, " size: ", zone_size)

func contains_point(pos: Vector2) -> bool:
	var local_pos = to_local(pos)
	var half = zone_size / 2
	var inside = (
		local_pos.x >= -half.x and local_pos.x <= half.x and
		local_pos.y >= -half.y and local_pos.y <= half.y
	)
	return inside

# Draw the zone visually using Godot's built in draw functions
# This is guaranteed to match contains_point exactly
func _draw():
	var half = zone_size / 2
	draw_rect(Rect2(-half, zone_size), Color(1, 0, 0, 0.3), true)   # filled
	draw_rect(Rect2(-half, zone_size), Color(1, 0, 0, 0.8), false)  # outline

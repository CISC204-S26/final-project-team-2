class_name MovingPlatform extends Node2D

@export var speed: float = 100.0
@export var loop: bool = true

var waypoints: Array[Vector2] = []
var current_waypoint: int = 0
var direction: int = 1

func _ready():
	# Grab all Marker2D children and use their positions as waypoints
	for child in get_children():
		if child is Marker2D:
			waypoints.append(child.global_position)
	
	if waypoints.size() < 2:
		print("WARNING: MovingPlatform needs at least 2 Marker2D children!")
		return
	
	global_position = waypoints[0]

func _physics_process(delta: float):
	if waypoints.size() < 2:
		return

	var target = waypoints[current_waypoint]
	global_position = global_position.move_toward(target, speed * delta)

	if global_position.distance_to(target) < 1.0:
		_advance_waypoint()

func _advance_waypoint():
	current_waypoint += direction

	if loop:
		if current_waypoint >= waypoints.size():
			direction = -1
			current_waypoint = waypoints.size() - 2
		elif current_waypoint < 0:
			direction = 1
			current_waypoint = 1
	else:
		current_waypoint = clamp(current_waypoint, 0, waypoints.size() - 1)

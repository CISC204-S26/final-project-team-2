extends CharacterBody2D

const SPEED = 100.0
@export var waypoints: Array[Marker2D] = []
var current_waypoint: int = 0
var facing_left: bool = false

func _physics_process(delta):
	if waypoints.is_empty():
		return
	
	var target = waypoints[current_waypoint].global_position
	var direction = (target - global_position).normalized()
	velocity = direction * SPEED
	
	# Only update facing when actually moving horizontally
	# im ngl i looked this up bc this flip shit was pissing me off
	if abs(direction.x) > 0.1:
		facing_left = direction.x > 0 
	
	$AnimatedSprite2D.flip_h = facing_left
	$AnimatedSprite2D.play("BeeFly")
	
	if global_position.distance_to(target) < 5.0:
		current_waypoint = (current_waypoint + 1) % waypoints.size()
	
	move_and_slide()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(1)

extends CharacterBody2D

const SPEED = 80.0

var player = null

func _ready():
	# Find the player in the scene
	player = get_tree().get_first_node_in_group("player")
	

func _physics_process(delta):
	if player == null:
		return
	
	# Chase the player
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_collide(delta * velocity)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()

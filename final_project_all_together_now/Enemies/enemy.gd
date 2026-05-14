extends CharacterBody2D

const SPEED = 80.0
const GRAVITY = 980.0
var direction = 1
var turn_cooldown = 0.0

func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	velocity.x = SPEED * direction
	
	turn_cooldown -= delta
	
	if turn_cooldown <= 0.0 and (is_on_wall() or not $FloorDetector.is_colliding()):
		direction *= -1
		$FloorDetector.target_position.x = 25 * direction
		$AnimatedSprite2D.flip_h = direction == +1
		turn_cooldown = 0.3  # short delay before it can flip again
	
	move_and_slide()


func _on_hurt_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(1)  # or body.die() if one hit kill

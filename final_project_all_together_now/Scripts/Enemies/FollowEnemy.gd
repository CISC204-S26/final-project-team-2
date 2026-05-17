extends CharacterBody2D

const SPEED = 25.0
const GRAVITY = 980.0
var direction = 1
var turn_cooldown = 0.0
var player_detected = false
var player = null

func _physics_process(delta):
	# Always apply gravity
	velocity.y += GRAVITY * delta
	
	if player_detected and player != null:
		# Chase the player
		$AnimatedSprite2D.play("BoarWalk")
		
		# Move toward player
		direction = sign(player.global_position.x - global_position.x)
		velocity.x = SPEED * direction
		
		# Flip da sprite
		$AnimatedSprite2D.flip_h = direction == +1
	else:
		# Idle when player not detected
		$AnimatedSprite2D.play("BoarIdle")
		velocity.x = 0
	
	move_and_slide()

func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player_detected = true

func _on_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		player_detected = false

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(1)

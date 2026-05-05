extends CharacterBody2D


@export var player_speed: int
@onready var animated_sprite = $AnimatedSprite2D  # Adjust path if named differently


# Gravity/jump height
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0 #Random ahh numbers

# Sets up interactables detector
var interactables = []
var was_on_floor := true
var facing_left := false
var is_landing := false


func _physics_process(delta: float) -> void:
	
	# Applies gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Jump
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("PlayerJumpStart")
	
	var direction = Input.get_axis("p1_left", "p1_right")
	
	# Movement
	if direction != 0:
		velocity.x = direction * player_speed
		# Flip horizontally when moving left
		facing_left = direction < 0
		animated_sprite.flip_h = facing_left
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		animated_sprite.flip_h = facing_left  # Faces last direction moveda
	
	# ------------------------ ANIMATIONS ---------------------------------------------
	if not is_on_floor():
		# Mid Air
		if velocity.y < 0:
			if animated_sprite.animation != "PlayerMidAir":
				animated_sprite.play("PlayerMidAir")
	
	else:
		# Player landed
		if not was_on_floor:
			animated_sprite.play("PlayerLanded")
			is_landing = true
		elif is_landing:
			pass
			
		# Only run/idle if not landing
		else:
			if direction != 0:
				if animated_sprite.animation != "PlayerRun":
					animated_sprite.play("PlayerRun")
			else:
				if animated_sprite.animation != "PlayerIdle":
					animated_sprite.play("PlayerIdle")
	
	was_on_floor = is_on_floor()
	
	if Input.is_action_just_pressed("interact"):
		if interactables:
			interactables.back().interact()
	
	move_and_slide()


func _on_interactable_detector_area_entered(area: Area2D):
	interactables.append(area)


func _on_interactable_detector_area_exited(area: Area2D):
	interactables.erase(area)


func teleport_to(pos: Vector2):
	global_position = pos
	print("Player 1 teleported to: ", pos)


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "PlayerLanded":
		is_landing = false
		
		if velocity.x != 0:
			animated_sprite.play("PlayerRun")
		else:
			animated_sprite.play("PlayerIdle")
	
	

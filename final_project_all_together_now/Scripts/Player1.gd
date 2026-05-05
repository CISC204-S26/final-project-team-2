extends CharacterBody2D

@export var player_speed: int

#gravity/jump height
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0 #Random ahh numbers

#sets up interactables detector
var interactables = []
@onready var animated_sprite = $AnimatedSprite2D  # adjust path if named differently

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		#animated_sprite.play("PlayerJump")
	
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_axis("p1_left", "p1_right")
	
	if direction != 0:
		velocity.x = direction * player_speed
		animated_sprite.play("PlayerRun")
		# Flip horizontally when moving left
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		animated_sprite.play("PlayerIdle")
		animated_sprite.flip_h = false  # reset flip when idle
	
	if Input.is_action_just_pressed("interact"):
		if interactables:
			interactables.back().interact()
	
	move_and_slide()


func _on_interactable_detector_area_entered(area: Area2D) -> void:
	interactables.append(area)


func _on_interactable_detector_area_exited(area: Area2D) -> void:
	interactables.erase(area)

func teleport_to(pos: Vector2):
	global_position = pos
	print("Player 1 teleported to: ", pos)

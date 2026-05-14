extends CharacterBody2D


@export var player_speed: int
@onready var animated_sprite = $AnimatedSprite2D  # Adjust path if named differently
@export var JUMP_VELOCITY = -400.0

const GRAVITY = 980.0 #Random ahh numbers

# Sets up interactables detector
var interactables = []
var was_on_floor := true
var facing_left := false
var is_landing := false

var health = 3
var is_dead := false

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("PlayerJumpStart")

	var direction = Input.get_axis("p1_left", "p1_right")

	if direction != 0:
		velocity.x = direction * player_speed
		facing_left = direction < 0
		animated_sprite.flip_h = facing_left
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
	# ------------------------ ANIMATIONS ---------------------------------------------
		animated_sprite.flip_h = facing_left

	if not is_on_floor():
		if velocity.y < 0:
			if animated_sprite.animation != "PlayerMidAir":
				animated_sprite.play("PlayerMidAir")
	else:
		if not was_on_floor:
			animated_sprite.play("PlayerLanded")
			is_landing = true
		elif is_landing:
			pass
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

func teleport_to(pos: Vector2, launch_dir: Vector2 = Vector2.UP, entry_speed: float = 0.0):
	global_position = pos
	# Preserve momentum along the launch direction
	var speed = max(entry_speed, 300.0)  # minimum boost so it always feels powerful
	velocity = launch_dir * speed
	#print("Player teleported to: ", pos, " launched at: ", launch_dir, " speed: ", speed)

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "PlayerLanded":
		is_landing = false
		if velocity.x != 0:
			animated_sprite.play("PlayerRun")
		else:
			animated_sprite.play("PlayerIdle")

func die():
	
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	animated_sprite.play("PlayerDeath")
	
	await get_tree().create_timer(1.5).timeout
	#restart scene on death
	get_tree().reload_current_scene()
	
	#ADD DEATH SCREEN 
	

func take_damage(amount: int):
	#lowkey ADD SOME SOUNDs PLS
	
	print("TOOK DAMAGE")
	health -= amount
	if health <= 0:
		die()

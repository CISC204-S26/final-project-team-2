extends CharacterBody2D

@export var player_speed: int
#@export var player_jump_height:int
#@export var player_gravity: int

#we might wanna have gravity/jump height an export var-
#in case we wanna make different levels with diff-
#gravity/jump height
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0

#sets up interactables detector
var interactables = []


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_axis("p1_left", "p1_right")
	
	if direction != 0:
		velocity.x = direction * player_speed #SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
	
	if Input.is_action_just_pressed("Interact"):
		if interactables:
			interactables.back().interact()
	move_and_slide()


func _on_interactable_detector_area_entered(area: Area2D) -> void:
	interactables.append(area)


func _on_interactable_detector_area_exited(area: Area2D) -> void:
	interactables.erase(area)

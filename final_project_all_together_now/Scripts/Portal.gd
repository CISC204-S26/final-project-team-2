class_name Portal extends Interactable

enum PortalType { ENTRY, EXIT }

@export var portal_type: PortalType = PortalType.ENTRY
var linked_portal: Portal = null
var launch_direction: Vector2 = Vector2.UP

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var _cooling_down_bodies: Array = []

func _ready():
	body_entered.connect(_on_body_entered)
	anim.animation_finished.connect(_on_animation_finished)
	open()

func open():
	anim.play("OpenPortal")

func _on_animation_finished():
	if anim.animation == "OpenPortal":
		anim.play("ActivePortal")

func close():
	anim.play("ClosePortal")

func _on_body_entered(body: Node) -> void:
	if body in _cooling_down_bodies:
		return
	if linked_portal == null:
		print("No portal linked yet!")
		return
	if _exit_is_in_blocked_zone():
		print("Exit portal is in a blocked zone — teleport cancelled!")
		return
	if body.has_method("teleport_to"):
		var entry_speed = body.velocity.length()
		_add_cooldown_for(body)
		linked_portal._add_cooldown_for(body)
		body.teleport_to(linked_portal.global_position, linked_portal.launch_direction, entry_speed)

func _add_cooldown_for(body: Node):
	_cooling_down_bodies.append(body)
	await get_tree().create_timer(0.8).timeout
	_cooling_down_bodies.erase(body)

func _exit_is_in_blocked_zone() -> bool:
	var zones = get_tree().get_nodes_in_group("no_portal_zone")
	for zone in zones:
		if zone.has_method("contains_point"):
			if zone.contains_point(linked_portal.global_position):
				return true
	return false

func interact():
	pass

func show_prompt():
	pass

func hide_prompt():
	pass

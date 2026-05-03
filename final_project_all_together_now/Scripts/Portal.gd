class_name Portal extends Interactable

enum PortalType { ENTRY, EXIT }

@export var portal_type: PortalType = PortalType.ENTRY

var linked_portal: Portal = null

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if portal_type != PortalType.ENTRY:
		return
	if linked_portal == null:
		print("No exit portal linked yet!")
		return
	if _exit_is_in_blocked_zone():
		print("Exit portal is in a blocked zone — teleport cancelled!")
		return
	if body.has_method("teleport_to"):
		body.teleport_to(linked_portal.global_position)

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

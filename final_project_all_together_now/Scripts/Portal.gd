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
	if body.has_method("teleport_to"):
		body.teleport_to(linked_portal.global_position)

func interact():
	pass

func show_prompt():
	pass

func hide_prompt():
	pass

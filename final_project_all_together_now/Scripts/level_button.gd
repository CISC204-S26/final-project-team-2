extends Button

@export var level: PackedScene

func _ready() -> void:
	self.connect("pressed", _on_pressed)

func _on_pressed() -> void:
	if level: get_tree().change_scene_to_packed(level)
	else: push_warning("No Level Assigned to Node.")

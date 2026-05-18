extends Node2D

@export var level: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Global.current_level = level

func _on_tree_exiting() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

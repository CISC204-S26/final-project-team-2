extends Node2D

@export var level: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_level = level

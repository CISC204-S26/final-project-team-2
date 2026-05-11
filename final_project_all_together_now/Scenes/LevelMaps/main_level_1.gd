extends Node2D

@export var level_index: int = 0  # set this to 0, 1, or 2 in the inspector per level


func _ready():
	Global.start_level_timer()


func _on_level_complete():
	Global.complete_level(level_index)
	# then do whatever load next scene, show results, etc.

extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var buttons = $CanvasLayer/LevelButtons.get_children()
	for i in range(Global.completed_levels.size()):
		if Global.completed_levels[i] == false:
			if i != 0: 
				buttons[i].disabled = true
				buttons[i].tooltip_text = "Complete the previous level first."

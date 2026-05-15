extends ColorRect


func _ready() -> void:
	visible = false

func _on_entered_talking() -> void:
	visible = true

func _on_exited_talking() -> void:
	visible = false

func _on_show_text(text: String) -> void:
	$TalkText.text = text

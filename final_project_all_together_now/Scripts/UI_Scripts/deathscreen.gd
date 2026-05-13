extends CanvasLayer


@onready var hover_sound = $HoverSound
@onready var click_sound = $ClickSound


func _on_restart_button_pressed() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/LevelMaps/main_level_1.tscn")


func _on_main_menu_button_pressed() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/UIMenus/MainMenu.tscn")


# ------------------------ SOUNDS SOUNDS SOUNDS ----------------------------------------
func play_hover_sound():
	hover_sound.play()


func play_click_sound():
	click_sound.play()

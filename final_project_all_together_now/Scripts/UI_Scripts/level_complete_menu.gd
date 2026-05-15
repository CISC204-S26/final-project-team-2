extends Control

@onready var click_sound = $ClickSound
@onready var hover_sound = $HoverSound

func _on_mouse_entered() -> void:
	hover_sound.play()

func _on_pressed() -> void:
	click_sound.play()

func _on_next_level_button_pressed() -> void:
	await get_tree().create_timer(.5).timeout
	if Global.current_level != Global.levels.size():
		get_tree().change_scene_to_file(Global.levels[Global.current_level])


func _on_level_select_button_pressed() -> void:
	await get_tree().create_timer(.5).timeout
	get_tree().change_scene_to_file("res://Scenes/UIMenus/LevelSelectMenu.tscn")


func _on_main_menu_button_pressed() -> void:
	await get_tree().create_timer(.5).timeout
	get_tree().change_scene_to_file("res://Scenes/UIMenus/MainMenu.tscn")

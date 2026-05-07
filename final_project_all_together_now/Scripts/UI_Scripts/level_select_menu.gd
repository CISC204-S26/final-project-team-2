extends CanvasLayer


@export var levels: Array[PackedScene]


@onready var main_menu_button = $MainMenuButton
@onready var level_one_button = $LevelButtons/LevelButton1
@onready var level_two_button = $LevelButtons/LevelButton2
@onready var level_three_button = $LevelButtons/LevelButton3
@onready var click_sound = $ClickSound
@onready var hover_sound = $HoverSound


# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons = $LevelButtons.get_children()
	
	for i in range(Global.completed_levels.size()):
			if Global.completed_levels[i] == false and i != 0:
				if i < buttons.size():
					buttons[i].disabled = true
					buttons[i].tooltip_text = "Complete the previous level first."


func _on_main_menu_button_pressed():
	await get_tree().create_timer(.5).timeout
	get_tree().change_scene_to_file("res://Scenes/UIMenus/MainMenu.tscn")


func _on_level_button_pressed(level_index: int):
	await get_tree().create_timer(.5).timeout
	
	if level_index < levels.size() and levels[level_index]: 
		get_tree().change_scene_to_packed(levels[level_index])
	else: 
		print("No Level Assigned for button: ", level_index)


# ------------------------ SOUNDS SOUNDS SOUNDS ----------------------------------------
func play_hover_sound():
	hover_sound.play()


func play_click_sound():
	click_sound.play()

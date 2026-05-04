extends CanvasLayer


@onready var main_buttons = $MainButtons
@onready var options_popup = $OptionsPopUp
@onready var vol_slider = $OptionsPopUp/VBoxContainer/VolumeSlider
@onready var title_card = $TitleLabel
@onready var click_sound = null
@onready var hover_sound = null
@onready var menu_music = null


func _ready():
	options_popup.hide()
	vol_slider.value_changed.connect(_on_volume_changed)


# ------------------ BUTTONS BUTTONS BUTTONS --------------------------------------------
func _on_start_button_pressed():
	#menu_music.stop()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/Test Scenes/test_scene.tscn")

func _on_options_button_pressed():
	main_buttons.hide()
	title_card.hide()
	options_popup.show()

func _on_back_button_pressed():
	main_buttons.show()
	title_card.show()
	options_popup.hide()

func _on_quit_button_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()

func _on_volume_changed(value):
	var db = linear_to_db(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)


# ------------------------ SOUNDS SOUNDS SOUNDS ----------------------------------------
func play_hover_sound():
	#hover_sound.play()
	pass

func play_click_sound():
	#click_sound.play()
	pass

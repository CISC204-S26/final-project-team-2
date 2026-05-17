extends CanvasLayer


@onready var main_buttons = $MainButtons
@onready var options_popup = $OptionsPopUp
@onready var vol_slider = $OptionsPopUp/VBoxContainer/VolumeSlider
@onready var paused_card = $PausedLabel
@onready var click_sound = $ClickSound
@onready var hover_sound = $HoverSound
var can_pause = true


func _ready():
	if $"../DoorInteractable":
		$"../DoorInteractable".connect("level_complete", _on_level_complete)
	hide()
	options_popup.hide()
	vol_slider.value_changed.connect(_on_volume_changed)


# ------------------- TOGGLE PAUSE TOGGLE PAUSE TOGGLE PAUSE-----------------------------
func _input(event):
	if event.is_action_pressed("pause") and can_pause:
		toggle_pause()

func toggle_pause():
	var new_state = !get_tree().paused
	get_tree().paused = new_state
	visible = new_state
	
	if new_state:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# ------------------ BUTTONS BUTTONS BUTTONS --------------------------------------------
func _on_resume_button_pressed():
	toggle_pause()

func _on_options_button_pressed():
	main_buttons.hide()
	paused_card.hide()
	options_popup.show()

func _on_back_button_pressed():
	main_buttons.show()
	paused_card.show()
	options_popup.hide()

func _on_main_menu_button_pressed():
	await get_tree().create_timer(.5).timeout
	can_pause = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	toggle_pause()
	get_tree().change_scene_to_file("res://Scenes/UIMenus/MainMenu.tscn")

func _on_restart_button_pressed() -> void:
	await get_tree().create_timer(.5).timeout
	can_pause = true
	toggle_pause()
	get_tree().reload_current_scene()


func _on_volume_changed(value):
	var db = linear_to_db(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)

# ------------------------ SOUNDS SOUNDS SOUNDS ----------------------------------------
func play_hover_sound():
	hover_sound.play()

func play_click_sound():
	click_sound.play()


func _on_level_complete() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	can_pause = false
	get_tree().paused = true
	visible = true
	$ColorRect.hide()
	$PausedLabel.hide()
	$MainButtons.hide()
	$LevelCompleteMenu.show()

func _on_tree_exiting() -> void:
	get_tree().paused = false
	can_pause = true


func _on_door_interactable_level_complete() -> void:
	pass # Replace with function body.

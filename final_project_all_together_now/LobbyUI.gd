extends CanvasLayer

func _on_host_pressed():
	NetworkManager.host_game()
	NetworkManager.player_connected.connect(_on_player_connected)

func _on_join_pressed():
	var ip = $VBoxContainer/IPInput.text
	NetworkManager.join_game(ip)
	get_tree().change_scene_to_file("res://Scenes/UIMenus/MainMenu.tscn")

func _on_player_connected():
	get_tree().change_scene_to_file("res://Scenes/UIMenus/MainMenu.tscn")

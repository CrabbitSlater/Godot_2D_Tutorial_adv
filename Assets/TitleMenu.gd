extends Control



func _on_PlayButton_pressed():
	Global.new_game()
	get_tree().change_scene("res://Assets/Levels/Test_Level.tscn")


func _on_SettingsButton_pressed():
	$Settings_tabs.visible=true
	GlobalSettings.accept_setting_commands = true


func _on_SettingsCloseButton_pressed():
	$Settings_tabs.visible=false
	GlobalSettings.accept_setting_commands = false


func _on_QuitButton_pressed():
	get_tree().quit()

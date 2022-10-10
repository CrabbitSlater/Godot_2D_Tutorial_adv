extends TabContainer


func _ready():
	
	$"Audio/Music Vol/Music Mute Check".pressed = GlobalSettings.music_mute
	$"Audio/SFX/SFX Mute Check".pressed = GlobalSettings.sfx_mute
	$"Visual/Fullscreen/FullscreenCheck".pressed = GlobalSettings.fullscreen
	
	GlobalSettings.menu_ref=self
	


func _on_FullscreenCheck_toggled(button_pressed):
	if.is_visible_in_tree():
		GlobalSettings.toggle_fullscreen(button_pressed)


func _on_Music_Mute_Check_toggled(button_pressed):
	print("the tabs menu is visible?")
	print(is_visible_in_tree())
	if.is_visible_in_tree():
		GlobalSettings.toggle_mute_music(button_pressed)


func _on_SFX_Mute_Check_toggled(button_pressed):
	if.is_visible_in_tree():
		GlobalSettings.toggle_mute_sfx(button_pressed)


func _on_MusicVolSlider_value_changed(value):
	if.is_visible_in_tree():
		GlobalSettings.set_music_vol(value)


func _on_SFXVol_value_changed(value):
	if.is_visible_in_tree():
		GlobalSettings.set_sfx_vol(value)

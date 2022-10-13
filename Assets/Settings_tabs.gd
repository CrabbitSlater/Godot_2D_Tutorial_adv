extends TabContainer

onready var fullscreen_button = $Visual/Fullscreen/FullscreenCheck
onready var sfx_mute = $Audio/SFX/SFXMuteCheck
onready var music_mute = $Audio/Music/MusicMuteCheck
onready var sfx_slider = $Audio/SFX/SFXVolSlider
onready var music_slider = $Audio/Music/MusicVolSlider

func _ready():
	
	GlobalSettings.menu_ref=self
	
	

func update_buttons():
	fullscreen_button.pressed = GlobalSettings.get_fullscreen()
	
	music_mute.pressed = GlobalSettings.get_music_mute()
	sfx_mute.pressed = GlobalSettings.get_sfx_mute()
	sfx_slider.value = GlobalSettings.get_sfx_vol()
	music_slider.value = GlobalSettings.get_music_vol()
	
	


func _on_FullscreenCheck_toggled(button_pressed):

	GlobalSettings.toggle_fullscreen(button_pressed)


func _on_Music_Mute_Check_toggled(button_pressed):
	print("the tabs menu is visible?")
	print(is_visible_in_tree())

	GlobalSettings.toggle_mute_music(button_pressed)


func _on_SFX_Mute_Check_toggled(button_pressed):

	GlobalSettings.toggle_mute_sfx(button_pressed)


func _on_MusicVolSlider_value_changed(value):

	GlobalSettings.set_music_vol(value)


func _on_SFXVol_value_changed(value):

	GlobalSettings.set_sfx_vol(value)


func _on_Settings_tabs_visibility_changed():
	self.update_buttons()
	print("updating buttons status, visibility is " + str(self.is_visible_in_tree()))
	print(GlobalSettings.saved_settings)
	GlobalSettings.accept_setting_commands = self.is_visible_in_tree()

func restore_defaults():
	pass
	GlobalSettings.set_sfx_vol(0.0)
	GlobalSettings.set_music_vol(0.0)
	GlobalSettings.toggle_mute_sfx(false)
	GlobalSettings.toggle_fullscreen(false)
	GlobalSettings.toggle_mute_music(false)
	GlobalSettings.accept_setting_commands = false
	update_buttons()
	GlobalSettings.accept_setting_commands = true 


func _on_Defaults_button_pressed():
	self.restore_defaults()


func _on_SettingsCloseButton_pressed():
	self.visible = false

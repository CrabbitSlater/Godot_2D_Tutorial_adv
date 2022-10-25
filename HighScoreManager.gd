extends Node

pass

""""
const SETTINGS_SAVE_FILE = "user://2dtutorial_settings.save"
#check save_file location and that file exists- print to terminal 

var saved_settings = {}

const MAX_VOL :float = 6.0
const MIN_VOL :float = -26.0

var menu_ref 

var accept_setting_commands = false

func _ready():
	load_settings()
	
func set_sfx_vol(new_vol:float):
	if accept_setting_commands:
		print("sfxv buttonpress")
		new_vol = clamp(new_vol, MIN_VOL, MAX_VOL)
		AudioServer.set_bus_volume_db(2,new_vol)
		saved_settings["sfx_vol"] = new_vol
		save_settings()
		
func get_sfx_vol():
	return saved_settings["sfx_vol"]
	
func set_music_vol(new_vol:float):
	if accept_setting_commands:

		print("mskv buttonpress")
		new_vol = clamp(new_vol, MIN_VOL, MAX_VOL)
		AudioServer.set_bus_volume_db(1,new_vol)
		saved_settings["music_vol"]=new_vol
		save_settings()

func get_music_vol():
	return saved_settings["music_vol"]

func toggle_mute_sfx(toggle:bool):
	if accept_setting_commands:

		print("msfx buttonpress")
		AudioServer.set_bus_mute(2,toggle)
		saved_settings["sfx_mute"]= toggle
		save_settings()
		
func get_sfx_mute():
	return saved_settings["sfx_mute"]

func toggle_mute_music(toggle:bool):

	if accept_setting_commands:
		print("mmsk buttonpress")
		AudioServer.set_bus_mute(1,toggle)
		saved_settings["music_mute"] = toggle
		save_settings()

func get_music_mute():
	return saved_settings["music_mute"]

func toggle_fullscreen(toggle:bool):

	if accept_setting_commands:
		print("fscr buttonpress")
		OS.set_window_fullscreen(toggle)
		saved_settings["fullscreen"] = toggle
		save_settings()
		
func get_fullscreen():
	return saved_settings["fullscreen"]

func set_settings():
	toggle_fullscreen(saved_settings["fullscreen"])
	#replace with resolution setting
	toggle_mute_music(saved_settings["music_mute"])
	toggle_mute_sfx(saved_settings["sfx_mute"])
	set_music_vol(saved_settings["music_vol"])
	set_sfx_vol(saved_settings["sfx_vol"])
	print("setting settings from var")
	print(saved_settings)


#add a signal or something to let the menu it need to update its button status 


func save_settings():
	
	print("trying to save setti gs")
	print(saved_settings)
	var file = File.new()
	file.open(SETTINGS_SAVE_FILE,File.WRITE)
	file.store_var(saved_settings)
	file.close()
	
func load_settings():
	var file = File.new()
	if not file.file_exists(SETTINGS_SAVE_FILE):
		saved_settings ={
			"fullscreen": false,
			"resolution" : 0,
			"sfx_mute" : false,
			"sfx_vol" : 0,
			"music_mute" : false,
			"music_vol" : 0 
		}
		save_settings()
	file.open(SETTINGS_SAVE_FILE,File.READ)
	saved_settings = file.get_var()
	file.close()
	self.accept_setting_commands = true
	set_settings()
	self.accept_setting_commands = false
	
"""
	

extends Node

const SETTINGS_SAVE_FILE = "user://2dtutorial_settings.save"

var saved_settings = {}

var fullscreen : bool = false
var sfx_mute : bool = false
var music_mute : bool = false
var music_vol : float =0
var sfx_vol : float = 0
var resolution =0
const MAX_VOL :float = 6.0
const MIN_VOL :float = -26.0

func _ready():
	load_settings()
	
func set_sfx_vol(new_vol:float):
	new_vol = clamp(new_vol, MIN_VOL, MAX_VOL)
	AudioServer.set_bus_volume_db(2,new_vol)
	self.sfx_vol=new_vol 
	save_settings()
	
func set_music_vol(new_vol:float):
	new_vol = clamp(new_vol, MIN_VOL, MAX_VOL)
	AudioServer.set_bus_volume_db(1,new_vol)
	self.music_vol=new_vol
	save_settings()

func toggle_mute_sfx(toggle:bool):
	AudioServer.set_bus_mute(2,toggle)
	self.sfx_mute=toggle
	save_settings()

func toggle_mute_music(toggle:bool):
	AudioServer.set_bus_mute(1,toggle)
	self.music_mute=toggle
	save_settings()
	
func toggle_fullscreen(toggle:bool):
	OS.set_window_fullscreen(toggle)
	self.fullscreen=toggle
	save_settings()

func set_settings():
	toggle_fullscreen(saved_settings["fullscreen"])
	#replace with resolution setting
	toggle_mute_music(saved_settings["music_mute"])
	toggle_mute_sfx(saved_settings["sfx_mute"])
	set_music_vol(saved_settings["music_vol"])
	set_sfx_vol(saved_settings["sfx_vol"])
	print(saved_settings)



func save_settings():
	
	
	saved_settings["fullscreen"] = self.fullscreen
	#replace with resolution setting
	saved_settings["music_mute"] = self.music_mute
	saved_settings["sfx_mute"] = self.sfx_mute
	saved_settings["music_vol"] = self.music_vol
	saved_settings["sfx_vol"] = self. sfx_vol
	
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
	set_settings()
	

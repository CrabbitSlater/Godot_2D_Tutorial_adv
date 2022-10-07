extends Node

var fullscreen : bool = false
var sfx_mute : bool = false
var music_mute : bool = false
var music_vol : float =0
var sfx_vol : float = 0
var resolution =0
const MAX_VOL :float = 6.0
const MIN_VOL :float = -26.0

func _ready():
	pass
	#loads the settings file, and if not present, creates one with default values

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

func save_settings():
	pass

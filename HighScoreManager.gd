extends Node

pass


const HISCORE_SAVE_FILE = "user://2dtutorial_hiscore.save"
#check save_file location and that file exists- print to terminal 

var saved_hiscore = []

func _ready():
	load_hiscores()
	

	

func add_hiscore(name:String, coins:int, enemies:int, time:int):
	
	#condition the name here- i.e. limit letters and allcaps 
	
	var scorelist = [name,coins,enemies,time]
	saved_hiscore.append(scorelist)




#add a signal or something to let the menu it need to update its button status 
func get_hiscores():
	return saved_hiscore


func save_hiscore():
	
	print("trying to save hiscore")
	print(saved_hiscore)
	var file = File.new()
	file.open(HISCORE_SAVE_FILE,File.WRITE)
	file.store_var(saved_hiscore)
	file.close()

func load_hiscores():
	var file = File.new()
	if not file.file_exists(HISCORE_SAVE_FILE):
		print("creating default file ")
		add_hiscore("poo",10,1,300)
		add_hiscore("bum",10,2,300)
		add_hiscore("ass",10,3,300)
		
		save_hiscore()
		
	file.open(HISCORE_SAVE_FILE,File.READ)
	saved_hiscore = file.get_var()
	file.close()

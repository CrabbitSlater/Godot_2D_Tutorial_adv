extends Node

pass

const MAX_HISCORES = 10
const HISCORE_SAVE_FILE = "user://2dtutorial_hiscore.save"
#check save_file location and that file exists- print to terminal 

var saved_hiscore = []

var current_score = ["DEBUG",1,2,998]

#flag to indicate a new highscore has been achived
var new_hiscore:bool =false

func is_current_score_hiscore():
	
	var lowest_coins:int = 999
	var low_coins_enemy:int = 999
	var low_coins_time:int = 999
	var lowest_enemies:int = 999
	var low_enemy_coin:int = 999
	var low_enemy_time:int =999
	var slowest_run:int = 9999
	
	for score in saved_hiscore:
		if score[1] < lowest_coins:
			lowest_coins = score[1]
			low_coins_enemy = score[2]
			low_coins_time = score[3]
		if score[2] <lowest_enemies:
			lowest_enemies = score[2]
			low_enemy_coin = score[1]
			low_enemy_time = score[3]
		if score[3] < slowest_run:
			slowest_run = score[3]
			
	print("least coins is : "+str(lowest_coins))
	print("least enemies is : "+str(lowest_enemies))
	print("slowest time is : "+str(slowest_run))
	
	#criterion for highscore- 
	#did you collect more coins than any of the existing hiscore entries? 
	#	elseif you collected the same as the lowest entry- did you kill more enemies? 
	#		elseif you killed the same, did you do it faster? 
	#elseif did you kill more enemies? 
	#	elseif you killed the same as the lowest entry- did you get more coins?
	#		elseif you killed the same enemies as the smallest number and the same coins, did you do it faster?
	
	#sort priority- coins>enemies>time
	
	return true

func _ready():
	load_hiscores()
	

	

func add_hiscore(name:String, coins:int, enemies:int, time:int):
	
	#condition the name here- i.e. limit letters and allcaps 
	
	var scorelist = [name,coins,enemies,time]
	saved_hiscore.append(scorelist)
	
	#sort highscores based on criteria in _is_currentscore_hiscore
	#trim list to MAX_HISCORE entries
	
	save_hiscore()




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
		add_hiscore("longwords",10,2,300)
		add_hiscore("hellote",10,3,65)
		add_hiscore("winky",69,420,65)
		
	file.open(HISCORE_SAVE_FILE,File.READ)
	saved_hiscore = file.get_var()
	file.close()

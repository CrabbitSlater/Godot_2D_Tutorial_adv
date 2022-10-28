extends Node



const MAX_HISCORES = 10
const HISCORE_SAVE_FILE = "user://2dtutorial_hiscore.save"
const TIMEBONUS_THRESHOLD = 180
const ENEMY_WEIGHT = 100
const COIN_WEIGHT = 1000

#check save_file location and that file exists- print to terminal 

var saved_hiscore = []

var current_score = ["ERR",0,0,999]

#flag to indicate a new highscore has been achived
#var new_hiscore:bool =false


func calc_hidden_score(coins:int, enemies:int, time:int):
	
	var hidden_bonus = 0
	
	if time < TIMEBONUS_THRESHOLD:
		
		hidden_bonus+=(time-TIMEBONUS_THRESHOLD)
	
	hidden_bonus+= COIN_WEIGHT*coins
	hidden_bonus+= ENEMY_WEIGHT*enemies
	
	return hidden_bonus


func is_current_score_hiscore() -> bool:
	
	#sort instead using hidden score
	
	var lowest_hidden_score:int = 999

	for score in saved_hiscore:
		if score[4] < lowest_hidden_score:
			lowest_hidden_score = score[4]
	
	print("lowest score is : "+str(lowest_hidden_score))
	var current_hidden_score = calc_hidden_score(current_score[1],current_score[2],current_score[3])
	print("current hidden score is : "+str(current_hidden_score))
	
	if current_hidden_score > lowest_hidden_score:
		return true
	
	return false
	
func add_current_score_as_highscore():
	add_hiscore(current_score[0],current_score[1],current_score[2],current_score[3])
	current_score = ["ERR",0,0,999]


	#criterion for highscore- 
	#did you collect more coins than any of the existing hiscore entries? 
	#	elseif you collected the same as the lowest entry- did you kill more enemies? 
	#		elseif you killed the same, did you do it faster? 
	#elseif did you kill more enemies? 
	#	elseif you killed the same as the lowest entry- did you get more coins?
	#		elseif you killed the same enemies as the smallest number and the same coins, did you do it faster?
	
	#sort priority- coins>enemies>time
	#coin waiting- one second beneath 3 mins = 1 pt, enemy is 100 pts, coin is 1000 pts 
	

func _ready():
	load_hiscores()
	

	

func add_hiscore(name:String, coins:int, enemies:int, time:int):
	
	#condition the name here- i.e. limit letters and allcaps 
	var hidden_score_entry = calc_hidden_score(coins,enemies,time)
	
	var scorelist = [name,coins,enemies,time,hidden_score_entry]
	
	saved_hiscore.append(scorelist)
	
	#sort highscores based on criteria in _is_currentscore_hiscore
	
	var sorted_scores =[]
	
	while len(sorted_scores) < len(saved_hiscore):
		
		var biggest_score =0
		var index_biggest:int = 0
		var index_temp:int = 0
		for score in saved_hiscore:
			if score[4] > biggest_score:
				biggest_score = score[4]
				index_biggest=index_temp
			index_temp+=1
			
		sorted_scores.append(saved_hiscore[index_biggest])
		#print("Biggest score is "+str(saved_hiscore[index_biggest])+" found at index: "+str(index_biggest))
		saved_hiscore[index_biggest][4] =0
		#print(str(saved_hiscore[index_biggest]))
	
	for score in saved_hiscore:
		score[4]=calc_hidden_score(score[1],score[2],score[3])
	
	saved_hiscore = sorted_scores
	
	#print('SORTING DONE\n\n'+ str(saved_hiscore)+" \n-----------\n\n")
	#trim list to MAX_HISCORE entries

	save_hiscore()




#add a signal or something to let the menu it need to update its button status 
func get_hiscores():
	return saved_hiscore


func save_hiscore():
	"""
	print("trying to save hiscore")
	print(saved_hiscore)
	"""
	var file = File.new()
	file.open(HISCORE_SAVE_FILE,File.WRITE)
	file.store_var(saved_hiscore)
	file.close()

func load_hiscores():
	var file = File.new()
	if not file.file_exists(HISCORE_SAVE_FILE):
		print("creating default file ")
		add_hiscore("a",10,5,300)
		add_hiscore("b",10,2,300)
		add_hiscore("c",10,3,300)
		add_hiscore("d",80,2,300)
		add_hiscore("e",99,3,65)
		add_hiscore("f",100,420,65)
		
	file.open(HISCORE_SAVE_FILE,File.READ)
	saved_hiscore = file.get_var()
	file.close()

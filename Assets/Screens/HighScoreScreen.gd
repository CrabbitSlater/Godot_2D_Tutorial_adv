extends Control


const SCORECONTAINER = preload("res://Assets/UI/ScoreContainer.tscn")
#cash the score container scene

func _ready():
	pass
	
	#test if current score would breach high score tables 
	#If so, prompt for name entry
	#if so, add to high score list (and sort) 
	#display 10 scores on list 
	
	var hiscores = HighScoreManager.get_hiscores()
	var entry : int =0
	for score in hiscores:
		var score_cont_temp = SCORECONTAINER.instance() 
		#^create an instance of scorecontainer in memory but NOT added to scene
		score_cont_temp.set_values(score[0],score[1],score[2],score[3])
		score_cont_temp.rect_position = Vector2(0,50*entry)
		entry+=1
		#^ assign details of score BEFORE adding to scene (overrides default)
		$HighScoreDisplayList.add_child(score_cont_temp)
		score_cont_temp.visible=true
	

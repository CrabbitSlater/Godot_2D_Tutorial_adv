extends Control


func _ready():
	#check current score 
	#gcoremanager-currentscore
	#update the winscore container
	var curr_score = HighScoreManager.current_score
	
	$WinScore.set_values("",curr_score[1],curr_score[2],curr_score[3])
	$WinScore.visible=true
	
	#if a highscore prompt for player name and suggest going to highscore screen
	#else do nothing 

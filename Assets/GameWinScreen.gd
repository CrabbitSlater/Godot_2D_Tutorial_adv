extends Control


func _ready():
	#check current score 
	#gcoremanager-currentscore
	#update the winscore container
	var curr_score = HighScoreManager.current_score
	
	$WinScore.set_values("",curr_score[1],curr_score[2],curr_score[3])
	$WinScore.visible=true
	
	if HighScoreManager.is_current_score_hiscore():
		print("New Highscore- display entername prompt and then suggest display scoretable")
		$HighscorePanel.visible=true
	#if a highscore prompt for player name and suggest going to highscore screen
	#else do nothing 


func _on_Accept_pressed():
	pass # Replace with function body.
	HighScoreManager.current_score[0] = $HighscorePanel/LineEdit.text
	HighScoreManager.add_current_score_as_highscore()
	$HighscorePanel.visible=false
	get_tree().change_scene("res://Assets/Screens/HighScore.tscn")

extends Node

# ^^ a singleton that handles lives

# a pointe to the hud, set by the HUD's onready function.
var hud 

var max_lives :int =3
var lives = max_lives

func new_game():
	lives= max_lives

func win_game():
	#tot up scores
	#if score is highscore, allow name entry
	#otherwise just show win screen and high scores 
	get_tree().change_scene("res://Assets/GameWinScreen.tscn")

func lose_life():
	lives-=1
	hud.load_hearts()
	if lives <=0:
		get_tree().change_scene("res://Assets/GameOverScreen.tscn")
	

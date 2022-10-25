extends Control

func _ready():
	$Title_Label/AnimationPlayer.play("Title_sway")

func _on_PlayButton_pressed():
	Global.new_game()
	get_tree().change_scene("res://Assets/Levels/Test_Level.tscn")


func _on_SettingsButton_pressed():
	$Settings_tabs.visible=true


func _on_SettingsCloseButton_pressed():
	$Settings_tabs.visible = false


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_HiScoreButton_pressed():
	#set hiscore new flag to false 
	get_tree().change_scene("res://Assets/Screens/HighScore.tscn")

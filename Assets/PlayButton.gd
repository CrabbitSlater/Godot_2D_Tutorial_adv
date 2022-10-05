extends Button




func _on_PlayButton_pressed():
	Global.new_game()
	get_tree().change_scene("res://Assets/Levels/Test_Level.tscn")

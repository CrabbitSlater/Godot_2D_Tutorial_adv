extends CanvasLayer

var coins:int = 0 
const HEARTS_WIDTH = 53


func _ready():
	$Coins.text=String(coins)
	load_hearts()
	Global.hud = self # give reference of ourselves to the global node 
	

func _on_coin_collected():
	coins +=1
	_ready()
	
func load_hearts():
	#Dont forget to enable expand on the hearts texturerect
	$HeartsFull.rect_size.x = Global.lives * HEARTS_WIDTH
	print("current lives = "+str(Global.lives))
	print("empty hearts size should be = "+str((Global.max_lives - Global.lives)))
	print("empty hearts width should be = "+str((Global.max_lives - Global.lives) * HEARTS_WIDTH))
	$HeartsEmpty.rect_size.x = (Global.max_lives - Global.lives) * HEARTS_WIDTH
	$HeartsEmpty.rect_position.x = $HeartsFull.rect_position.x + $HeartsFull.rect_size.x *$HeartsFull.rect_scale.x
	
func _process(delta):
	if Input.is_action_just_pressed("Pause_menu"):
		
		print("pausePress")
	
		if not $PauseMenu.is_visible_in_tree():
			$PauseMenu/PauseTitle/AnimationPlayer.play("Pause_sway")
			$PauseMenu.visible=true 
			get_tree().paused = true
		else:
			$PauseMenu.visible=false 
			get_tree().paused = false
			


func _on_Resume_button_pressed():
	$PauseMenu.visible = false
	get_tree().paused = false
	


func _on_SettingsButton_pressed():
	$PauseMenu/Settings_tabs.visible = true


func _on_Quit_to_menu_pressed():
	#dont forget to unpause!
	get_tree().paused=false
	get_tree().change_scene("res://Assets/TitleMenu.tscn")
	

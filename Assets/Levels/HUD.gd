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
			$PauseMenu.visible=true 
			get_tree().paused = true
		else:
			$PauseMenu.visible=false 
			get_tree().paused = false
			


func _on_Resume_button_pressed():
	$PauseMenu.visible = false
	get_tree().paused = false
	

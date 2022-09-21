extends CanvasLayer

var coins:int = 0 

func _ready():
	$Coins.text=String(coins)
	

func _on_coin_collected():
	coins +=1
	_ready()

extends Control


func _ready():
	pass

func set_values(coins:int=0, enemies:int=0, time:int=3600.0, player:String="Player") -> void:
	
	$CoinPair/CoinLabel.text=str(coins)
	$EnemyPair/EnemyLabel.text=str(enemies)
	$PlayerName.text=player
	var mins = floor(time/60)
	var seconds = round(time%60)
	$TimeLabel.text =(str(mins) + ":" +str(seconds))
	self.visible=true

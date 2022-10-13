extends Area2D


func _ready():
	pass


func _on_WinZone_body_entered(body):
	$AudioStreamPlayer2D.play()
	$Timer.start()



func _on_Timer_timeout():
		Global.win_game()

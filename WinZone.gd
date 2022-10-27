extends Area2D

signal won_game

func _ready():
	pass


func _on_WinZone_body_entered(body):
	emit_signal("won_game")
	$AudioStreamPlayer2D.play()
	$Timer.start()



func _on_Timer_timeout():
		Global.win_game()

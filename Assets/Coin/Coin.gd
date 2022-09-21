extends Area2D




func _on_Coin_body_entered(body):
	#Collection script
	
	#free the coin from memory 
	queue_free()

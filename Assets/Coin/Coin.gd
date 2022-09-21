extends Area2D




func _on_Coin_body_entered(body):
	#Collection script
	#access other chold node with dolla
	$AnimationPlayer.play("Bounce")
	#Call Player's collect coin script (as on player mask, should only be a 
	#layer that collides
	#WARNING- for best practice, shoud check that this method exists on other 
	#ßentity- or check gorup or class
	body.add_coin()
	

func _on_AnimationPlayer_animation_finished(anim_name):
	#free coin from memory 
	queue_free()

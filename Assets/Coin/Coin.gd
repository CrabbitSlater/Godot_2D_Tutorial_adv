extends Area2D


#custom signal that we emit
signal coin_collected

func _on_Coin_body_entered(body):
	#Collection script
	
	#change the collision mask to disable collision with coin
	set_collision_mask_bit(0,false)
	
	#access other chold node with dolla
	$AnimationPlayer.play("Bounce")
	#Call Player's collect coin script (as on player mask, should only be a 
	#layer that collides
	#WARNING- for best practice, shoud check that this method exists on other 
	#ßentity- or check gorup or class
	emit_signal("coin_collected")
	$SoundCoinCollect.play()
	
	

func _on_AnimationPlayer_animation_finished(anim_name):
	#free coin from memory 
	queue_free()

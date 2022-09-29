extends KinematicBody2D

var velocity = Vector2()
const SPEED : int = 800
const GRAVITY = 22
const BOUNCE = -300
const SPIN_SPEED = 45
var direction =1


func _ready():
	velocity.x = SPEED * direction
	
func _physics_process(delta):
	$Sprite.rotation_degrees+=SPIN_SPEED
	velocity.y += GRAVITY
	
	if self.is_on_wall():
		queue_free()
	if self.is_on_floor():
		velocity.y = BOUNCE
		
	
	
	velocity = move_and_slide(velocity,Vector2.UP)
	#dont forget to designate 'up' durection 
	



func _on_VisibilityNotifier2D_screen_exited():
	#if visibility notifier node says we are off screeen
	self.queue_free()


func _on_Timer_timeout():
	#wait a fraction before playing fireball sound in case fireball hits wall 
	#close to spawn
	$AudioStreamPlayer.play()

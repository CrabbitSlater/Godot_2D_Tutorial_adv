extends KinematicBody2D

var velocity: Vector2  = Vector2(0.0,0.0)




export var gravity : float = 35.0
export var  top_speed : float = 300
export var acceleration : float = 1000
export var friction_lerp_coeff : float = 0.2
export var jump_force : float = -900
var stunned : bool = false

var coins : int = 0
#onready var 


func _physics_process(delta):
	
	if Input.is_action_pressed("player_right")and not stunned:
		velocity.x += acceleration*delta
		$Sprite.play("Walk")
		#dollar sign allows somone to access child node by name
	elif Input.is_action_pressed("player_left") and not stunned:
		velocity.x -= acceleration*delta
		$Sprite.play("Walk")
	else:
		if not stunned:
			velocity.x = lerp(velocity.x,0,friction_lerp_coeff)
			if abs(velocity.x) <=1:
				velocity.x =0
			$Sprite.play("Idle")
	
	#check conditions for animated sprite, i.e. in air and facing 
	if not self.is_on_floor():
		$Sprite.play("Air")
	if velocity.x<0:
		$Sprite.flip_h = true
	elif velocity.x>0:
		$Sprite.flip_h = false
		
	
	
	#set stop speed for steve
	velocity.x = clamp(velocity.x,-top_speed,+top_speed)
	
	#apply gravity to steve 
	velocity.y += gravity 
	
	#check jump action for steve 
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y=jump_force
		$SoundJump.play()

	velocity = move_and_slide(velocity,Vector2.UP)
	#move and slide returns an adjusted velocity! use this to reset y velocity to zero on floor 
	

	


func _on_Fall_Zone_body_entered(body):
	#WARNING_ this is critical you check it is STEVE who is touching the fall zone, otherwise the 
	#tiles will continually trigger a level reload- will be addrssed with collision layers later on 
	#if body.name=="Steve":
	
	#sorted this bug using collisions layers- fall zone now only detects things on player 
	
	get_tree().change_scene("res://Assets/GameOverScreen.tscn")
	
	#pass # Replace with function body.
	
func add_coin():
	coins +=1
	print("Coins now "+str(coins))

func bounce():
	velocity.y=jump_force*0.5
	
func ouch(var enemy_pos_x):
	self.set_modulate(Color(1,0.3,0.3,0.6))
	#get relative position of thing that ouched us to ourselves
	
	
	if self.position.x < enemy_pos_x:
		velocity.x = jump_force*0.3
		print("enemy hits right of steve")
		
	elif self.position.x > enemy_pos_x:
		velocity.x = -jump_force*0.3
		print("enemy hits left of steve")
		
	velocity.y=jump_force*0.5
	#temporarily disable player input 
	Input.action_release("player_left")
	Input.action_release("player_right")
	#start timer to reset level
	stunned=true
	$Timer.start()	


func _on_Timer_timeout():
	get_tree().change_scene("res://Assets/GameOverScreen.tscn")

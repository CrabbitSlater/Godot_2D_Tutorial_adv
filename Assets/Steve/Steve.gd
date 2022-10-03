extends KinematicBody2D

#use an enum to enumerate states for finite state machine
enum States {AIR=1, FLOOR, LADDER, WALL} #states enumerated at air =1 first, then floor = 2 etc

var state = States.AIR


#fireball is const and also preloaded to minimise memory strain 
const FIREBALL = preload("res://Assets/Fireball/Fireball.tscn")

var velocity: Vector2  = Vector2(0.0,0.0)
export var gravity : float = 35.0
export var  top_speed : float = 300
const  LADDER_SPEED  = 200
export var top_run_speed : float = 450
export var top_air_speed : float = 400
export var acceleration : float = 1000
export var run_acceleration : float = 1500
export var friction_lerp_coeff : float = 0.2
export var jump_force : float = -900
export var wall_kick_force :float = 450
var direction : int = 1
var last_jump_direction :int =0
var on_ladder := false #statically typed variable! use these as often as we can

var coins : int = 0
#onready var 


func _physics_process(delta):
	
	print(on_ladder)
	#match statement is like a switch case  i.e. see if self.state 
	#is equal to any of the following states in the enum
	match self.state: 
		States.AIR:
			if is_on_floor():
				self.state = States.FLOOR
				last_jump_direction=0
				continue #skips rest of code in this match case 
			elif is_near_wall():
				state=States.WALL
				continue
			elif should_climb_ladder():
				self.state = States.LADDER
				continue
				
			$Sprite.play("Air")
			if Input.is_action_pressed("player_right"):
				velocity.x += acceleration*delta
				$Sprite.flip_h = false
			elif Input.is_action_pressed("player_left"):
				velocity.x -= acceleration*delta
				$Sprite.flip_h = true
			else:
				velocity.x = lerp(velocity.x,0,friction_lerp_coeff)
			velocity.x = clamp(velocity.x,-top_air_speed,+top_air_speed)
			set_direction()
			move_and_fall(false)
			fire()
			
		States.FLOOR:
			
			if not is_on_floor():
				self.state=States.AIR
				continue
			elif should_climb_ladder():
				self.state=States.LADDER
			
			
			
			if Input.is_action_pressed("player_right"):
				if Input.is_action_pressed("player_run"):
					$Sprite.set_speed_scale(3.0)
					velocity.x += run_acceleration*delta
					velocity.x = clamp(velocity.x,-top_run_speed,+top_run_speed)
				else:
					$Sprite.set_speed_scale(1.0)
					velocity.x += acceleration*delta
					velocity.x = clamp(velocity.x,-top_speed,+top_speed)
				$Sprite.flip_h = false
				$Sprite.play("Walk")
				#dollar sign allows somone to access child node by name
			elif Input.is_action_pressed("player_left"):
				if Input.is_action_pressed("player_run"):
					$Sprite.set_speed_scale(3.0)
					velocity.x -= run_acceleration*delta
					velocity.x = clamp(velocity.x,-top_run_speed,+top_run_speed)
				else:
					$Sprite.set_speed_scale(1.0)
					velocity.x -= acceleration*delta
					velocity.x = clamp(velocity.x,-top_speed,+top_speed)
				$Sprite.flip_h = true
				$Sprite.play("Walk")
			else:
				velocity.x = lerp(velocity.x,0,friction_lerp_coeff)
				if abs(velocity.x) <=1:
					velocity.x =0
				$Sprite.play("Idle")
			
				#check jump action for steve 
			if Input.is_action_just_pressed("player_jump"):
				velocity.y=jump_force
				$SoundJump.play()
				self.state=States.AIR
			set_direction()
			move_and_fall(false)
			fire()
			
		States.WALL:
			
			if is_on_floor():
				state = States.FLOOR
				last_jump_direction=0
				continue
			elif not is_near_wall():
				state = States.AIR
				continue
			
			$Sprite.play("Wall")
			
			if  (last_jump_direction != direction) and Input.is_action_pressed("player_jump") and ((Input.is_action_pressed("player_left") and direction==1) or (Input.is_action_pressed("player_right") and direction==-1)):
				last_jump_direction=direction
				velocity.x = wall_kick_force* -direction
				velocity.y= jump_force *0.7
				$SoundJump.play()
				state = States.AIR
			move_and_fall(true)
			
		States.LADDER:
			
			if not on_ladder:
				state = States.AIR
				continue
			elif is_on_floor() and Input.is_action_pressed("player_down"):
				state = States.FLOOR
				Input.action_release("player_down")
				continue
				#force release of up or down so we dont cycle between floor and ladder states
			elif Input.is_action_pressed("player_jump"):
				Input.action_release("player_up")
				Input.action_release("player_down")
				velocity.y = jump_force *0.7
				$SoundJump.play()
				self.state=States.AIR
				continue
				
				
				
			
			
			
			if Input.is_action_pressed("player_up") or Input.is_action_pressed("player_down") or Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
				$Sprite.speed_scale=1
				$Sprite.play("Climb")
			else: 
				$Sprite.stop()
				
			if Input.is_action_pressed("player_up"):
				velocity.y = -LADDER_SPEED
			elif Input.is_action_pressed("player_down"):
				velocity.y = LADDER_SPEED
			else: 
				velocity.y = lerp(velocity.y,0,0.3)
			
			if Input.is_action_pressed("player_left"):
				self.velocity.x = -LADDER_SPEED/6
			elif Input.is_action_pressed("player_right"):
				self.velocity.x = LADDER_SPEED/6
			else: 
				self.velocity.x = lerp(self.velocity.x,0,0.3)
			
			
			self.velocity = move_and_slide(self.velocity,Vector2.UP)
			
			
			
	
#static return type on function! use theese standards 
func should_climb_ladder() -> bool:
	if on_ladder and (Input.is_action_pressed("player_up") or Input.is_action_pressed("player_down")):
		return true
	else:
		return false
	
func set_direction():
	
	direction = 1 if not $Sprite.flip_h else -1
	$WallChecker.rotation_degrees = 90 * -direction
	
func is_near_wall():
	return $WallChecker.is_colliding()

func fire():
	if Input.is_action_just_pressed("player_fire") and not is_near_wall():
		var f = FIREBALL.instance() 
		#^create an instance of fireball in memory but NOT added to scene
		f.direction = direction
		#^ assign direction of the fireball BEFORE adding to scene (overrides default)
		get_parent().add_child(f)
		#add instance fireball to parent of steve (the scene) 
		f.position.y = self.position.y
		f.position.x = self.position.x +25*direction
		#^offset x position of fireball 

func move_and_fall(slow_fall : bool):
	velocity.y += gravity 
	
	if slow_fall:
		velocity.y = clamp(velocity.y,jump_force,200)
	
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
	$Timer.start()	


func _on_Timer_timeout():
	get_tree().change_scene("res://Assets/GameOverScreen.tscn")


func _on_LadderChecker_body_entered(body):
	#ladder checker only has a mask for ladder tiles 
	on_ladder=true
	pass # Replace with function body.
	
func _on_LadderChecker_body_exited(body):
	on_ladder = false
	pass # Replace with function body.

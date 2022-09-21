extends KinematicBody2D

var velocity: Vector2  = Vector2(0.0,0.0)


export var gravity : float = 35.0
export var  top_speed : float = 300
export var acceleration : float = 1000
export var friction_lerp_coeff : float = 0.1
export var jump_force : float = -1100


func _physics_process(delta):
	
	if Input.is_action_pressed("player_right"):
		velocity.x += acceleration*delta

	elif Input.is_action_pressed("player_left"):
		velocity.x -= acceleration*delta

	else:
		velocity.x = lerp(velocity.x,0,friction_lerp_coeff)
	
	velocity.x = clamp(velocity.x,-top_speed,+top_speed)
	
	velocity.y += gravity 
	
	print("we are on floor? " + str(is_on_floor()))
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y=jump_force

	velocity = move_and_slide(velocity,Vector2.UP)
	#move and slide returns an adjusted velocity! use this to reset y velocity to zero on floor 
	
	
	

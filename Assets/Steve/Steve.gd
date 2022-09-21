extends KinematicBody2D

var velocity: Vector2  = Vector2(0.0,0.0)


export var gravity : float = 15.0
export var top_speed : float = 300
export var acceleration : float = 1000
export var friction_lerp_coeff : float = 0.1


func _physics_process(delta):
	
	if Input.is_action_pressed("player_right"):
		velocity.x += acceleration*delta
		print("right")
	elif Input.is_action_pressed("player_left"):
		velocity.x -= acceleration*delta
		print("left")
	else:
		velocity.x = lerp(velocity.x,0,friction_lerp_coeff)
	
	velocity.x = clamp(velocity.x,-top_speed,+top_speed)

	move_and_slide(velocity)
	
	
	

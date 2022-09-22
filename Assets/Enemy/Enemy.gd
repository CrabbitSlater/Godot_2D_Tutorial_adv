extends KinematicBody2D

var velocity = Vector2()
var gravity :float = 20
export var direction = -1  #left is -1, right it +1
var speed :float = 75

export var detects_cliffs : bool = true


func _ready():
	#ensure that sprite is flipped right
	if direction >0 : 
		$AnimatedSprite.flip_h = true
		#position floorchecker raycast- note that get_extents onlly exists on 
		#rectangle and similar shapes
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x *direction
		#note also that etents is distane from origin to the edge of the shape- not the full width
		#note- raycasting is expensive- try to minimise use of them  
		$FloorChecker.enabled = detects_cliffs
	
func _physics_process(delta):
	
	#check if on wall - check also if it's on the floor, and if the floor detector can sense a drop
	#floor detection important otherwise enemy will flip wildly if in freefall
	#also need to condition this on if it detects cliffs 
	#this is pretty long for a single conditional, maybe look into multiline formatting in gd script 
	
	if is_on_wall() or detects_cliffs and self.is_on_floor() and not $FloorChecker.is_colliding():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x *direction
		#flip the position of the raycast to other side 
	
	velocity.y += gravity
	
	velocity.x = speed*direction
	
	#dont forget to add the UP variable 
	velocity = self.move_and_slide(velocity,Vector2.UP)

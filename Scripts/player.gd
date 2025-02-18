extends CharacterBody2D


const SPEED = 150.0
const MAX_SPEED = 200.0
const JUMP_VELOCITY = -350.0
const ACCELERATION = 5.0
const SPEED_DELTA = 20.0

@export var direction = 0

@onready var label: Label = $Label
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dayS:bool = true
var isMoving:bool = true
var isDashing:bool = false
var timeInAir:float = 0

var idleAnim:String = "idle_day"
var runAnim:String = "run_day"
var jumpAnim:String = "jump_day"

func _physics_process(delta: float) -> void:
	#table for 
	label.text = "Velocity.x = %d \nVelocity.y = %d" % [velocity.x, velocity.y]
	# Add the gravity.
	if not is_on_floor():
		if not isDashing:
			velocity += get_gravity() * delta * 1.2
		timeInAir += delta
	else:
		timeInAir = 0
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or timeInAir < 0.1):
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("interact"):
		if dayS:
			_on_time_of_day_change("NIGHT")
			dayS = !dayS
		else:
			_on_time_of_day_change("DAY")
			dayS = !dayS
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play(idleAnim)
		else:
			animated_sprite_2d.play(runAnim)
	else:
		animated_sprite_2d.play(jumpAnim)
	
	
	
		
	if direction and isMoving:
		if Input.is_action_pressed("sprint") and is_on_floor():
			if abs(velocity.x) <= MAX_SPEED:
				velocity.x += ACCELERATION * direction
		else:
			velocity.x = move_toward(velocity.x, direction * SPEED, SPEED_DELTA)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_DELTA)
		
	move_and_slide()
		

	
func _on_time_of_day_change(dayState: String):
	if dayState == "DAY":
		idleAnim = "idle_day"
		jumpAnim = "jump_day"
		runAnim = "run_day"
	else:
		idleAnim = "idle_night"
		jumpAnim = "jump_night"
		runAnim = "run_night"

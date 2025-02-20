class_name DashComponent
extends Node

@export var characterBody:CharacterBody2D
@export var cooldown:float = 2
@export var airDashStrength:float = 5
@export var airDashDuration:float = 0.2
var isOnCooldown:bool = false
var dashingDirection = 1

var last_keycode = 0
var drop_started = false
const DOUBLETAP_DELAY = 0.25
var double_down_time = DOUBLETAP_DELAY


func air_dash() -> void:
	isOnCooldown = true
	characterBody.isDashing = true
	get_tree().create_timer(cooldown).timeout.connect(set.bind("isOnCooldown", false))
	dashingDirection = characterBody.direction
	var prevVel = characterBody.velocity
	get_tree().create_timer(airDashDuration).timeout.connect(func():
		characterBody.velocity = Vector2.ZERO
		characterBody.isDashing = false
		)
		
func air_drop() -> void:
	characterBody.velocity = Vector2(0, 300)
	characterBody.move_and_slide()
	if characterBody.is_on_floor():
		drop_started = false
		characterBody.isMoving = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	double_down_time -= delta
	if drop_started:
		air_drop()
	
#region Air Dash
	# the game checks if the playerd is holding shift (same as sprint) and is in the air for longer than 0.2s.
	# that ensures that even is the player is sprinting 
	# and then jumps still holding shift it will dash but not instantly when he's off the floor
	if Input.is_action_pressed("sprint") and characterBody.timeInAir > 0.2 and !isOnCooldown:
		air_dash()
	
	# each frame the X velocity is equal to the Air Dash Strength and Y is 0 to make the dash horizontal
	if characterBody.isDashing and dashingDirection:
		characterBody.velocity = Vector2(airDashStrength * dashingDirection, 0)
		characterBody.move_and_slide()
#endregion
	
func _input(event: InputEvent) -> void:	
#region Air Drop
	if event is InputEventKey and event.is_pressed():
		if last_keycode == event.keycode and double_down_time >= 0 and event.is_action_pressed("move_down"):
			characterBody.isMoving = false
			drop_started = true
			last_keycode = 0
		else:
			last_keycode = event.keycode
		double_down_time = DOUBLETAP_DELAY
#endregion

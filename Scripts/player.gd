extends CharacterBody2D


var player_speed
var player_max_speed
var player_jump_velocity
var player_acceleration
var player_speed_delta
var player_health

@export var player_speed_boost: float
@export var player_health_boost: int

@export_category("Player Inventory")
@export var player_currency: int = 0

@export_category("Player Un-saved inventory")
@export var money_found: int =  0
@export var water_quality_change: int = 0
@export var villager_happiness_change: int = 0
@export var population_health_change: int = 0
@export var chaos_change: int = 0
@export var good_change: int = 0

var direction = 0

@onready var label: Label = $Label
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dayS:bool = true
var isMoving:bool = true
var isDashing:bool = false
var timeInAir:float = 0

var idleAnim:String = "idle_day"
var runAnim:String = "run_day"
var jumpAnim:String = "jump_day"

func _ready():
	for goal in get_tree().get_nodes_in_group("goal"):
		if not goal.is_connected("playerInGoal", Callable(self, "_on_goal_reached")):
			var error = goal.connect("playerInGoal", Callable(self, "_on_goal_reached"))
			if error == OK:
				print("goal signal connected to player")
			else:
				print("failed to connect goal group signal to player")
	set_base_stats()
	apply_stat_modifiers()

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
		velocity.y = player_jump_velocity
		
	if Input.is_action_just_pressed("interact"):
		if dayS:
			_on_time_of_day_change("NIGHT")
			dayS = !dayS
		else:
			_on_time_of_day_change("DAY")
			dayS = !dayS
	var direction = Input.get_axis("move_left", "move_right")
	
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
			if abs(velocity.x) <= player_max_speed:
				velocity.x += player_acceleration * direction
		else:
			velocity.x = move_toward(velocity.x, direction * player_speed, player_speed_delta)
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed_delta)
		
	move_and_slide()
		
	
func set_base_stats():
	player_speed = Player_Properties.BASE_SPEED
	player_health = Player_Properties.PLAYER_BASE_HEALTH
	player_jump_velocity = Player_Properties.JUMP_VELOCITY
	player_acceleration = Player_Properties.ACCELERATION
	player_speed_delta = Player_Properties.SPEED_DELTA
	player_max_speed = Player_Properties.MAX_SPEED
	
func apply_stat_modifiers():
	player_speed += player_speed_boost
	player_health += player_health_boost
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	
func _on_time_of_day_change(dayState: String):
	if dayState == "DAY":
		idleAnim = "idle_day"
		jumpAnim = "jump_day"
		runAnim = "run_day"
	else:
		idleAnim = "idle_night"
		jumpAnim = "jump_night"
		runAnim = "run_night"
		
		
func _level_start():
	money_found = 0
	water_quality_change = 0
	villager_happiness_change = 0
	population_health_change = 0
	chaos_change = 0
	good_change = 0
	

func _on_goal_reached(data: Dictionary):
	print("on_goal_reached triggered")
	if data.has("gold"):
		PlayerProperties.player_money += data["gold"]
		print("Updated Player Gold: ", PlayerProperties.player_money)
	
	var town = get_parent()
	if town:
		print("town node found, ",town)
		town.update_town_stats(data)
	else: 
		print("depression")

func add_gold(gold: int):
	money_found += gold
	print("Player found: ", gold, ", add_gold triggered")

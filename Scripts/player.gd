extends CharacterBody2D

@export var player_speed_boost: float
@export var player_health_boost: int
@export var player_health: int = 100
@export_category("Player Inventory")
@export var player_currency: int = 0

@export_category("Player Un-saved inventory")
@export var money_found: int =  0
@export var water_quality_change: int = 0
@export var villager_happiness_change: int = 0
@export var population_health_change: int = 0
@export var chaos_change: int = 0
@export var good_change: int = 0


var player_properties:= PlayerProperties

var direction = 0

@onready var label: Label = $Label
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dayS:bool = true
var isMoving:bool = true
var isDashing:bool = false
var isHurt:bool = false
var timeInAir:float = 0

var idleAnim:String = "idle"
var runAnim:String = "run"
var jumpAnim:String = "jump_up"
var hurtAnim:String = "hurt"

func _ready():
	initialize_playerProperties()
	#set_base_stats()
	#apply_stat_modifiers()

func _physics_process(delta: float) -> void:
	#table for 
	PlayerProperties.player_position = global_position
	#label.text = "Velocity.x = %d \nVelocity.y = %d \nCurrentSpeed = %d" % [velocity.x, velocity.y, player_properties.current_speed]
	# Add the gravity.
	if not is_on_floor():
		if not isDashing:
			velocity += get_gravity() * delta * player_properties.gravity_modifier
		timeInAir += delta
	else:
		timeInAir = 0
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or timeInAir < 0.1) and isMoving and !PlayerProperties.disable_jump:
		velocity.y = player_properties.JUMP_VELOCITY
		

	
	if isHurt:
		pass
	else:
		direction = Input.get_axis("move_left", "move_right")
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play(idleAnim)
			#else:
			elif velocity.x != 0:
				animated_sprite_2d.play(runAnim)
		else:
			animated_sprite_2d.play(jumpAnim)
	
	if direction > 0:
		animated_sprite_2d.flip_h = true
	elif direction < 0:
		animated_sprite_2d.flip_h = false
	
	
		
	if direction and isMoving:
		if Input.is_action_pressed("sprint") and is_on_floor():
			if abs(velocity.x) <= player_properties.MAX_SPEED:
				velocity.x += player_properties.ACCELERATION * direction
		else:
			velocity.x = move_toward(velocity.x, direction * player_properties.current_speed, player_properties.SPEED_DELTA)
	else:
		velocity.x = move_toward(velocity.x, 0, player_properties.SPEED_DELTA)
		
	move_and_slide()
	
	
	
func _on_time_of_day_change(dayState: String):
	if dayState == "DAY":
		idleAnim = "idle"
		jumpAnim = "jump_up"
		runAnim = "run"
	else:
		#idleAnim = "idle_night"
		#jumpAnim = "jump_night"
		#runAnim = "run_night"
		pass
		
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
		Town.update_town_stats(data)
	

func add_gold(gold: int):
	money_found += gold
	print("Player found: ", gold, ", add_gold triggered")
	
	
func initialize_playerProperties():
	self.set_collision_layer(PlayerProperties.player_collision_layer)
	print("player layer 2:", self.get_collision_layer_value(2))
	print("player layer 1:" ,self.get_collision_layer_value(1))
	add_to_group("player")
	var debug = get_groups()
	print("Player in group",debug)
	for goal in get_tree().get_nodes_in_group("goal"):
		if not goal.is_connected("playerInGoal", Callable(self, "_on_goal_reached")):
			var error = goal.connect("playerInGoal", Callable(self, "_on_goal_reached"))
			if error == OK:
				print("goal signal connected to player")
			else:
				print("failed to connect goal group signal to player")
				
func take_damage():
	player_health -= 30
	animated_sprite_2d.play(hurtAnim)
	print("damage taken by player, current hp: ", player_health)

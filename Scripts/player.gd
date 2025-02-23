extends CharacterBody2D
@onready var hurt: AudioStreamPlayer2D = $Audio/hurt

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
@export_category("Walk Speed Sounds")
@onready var walk: AudioStreamPlayer2D = $Audio/walk
@export var walk_sound_timer: float = 0.4
var player_properties:= PlayerProperties
@onready var jump: AudioStreamPlayer2D = $Audio/Jump

var spawnPoint: Vector2 = Vector2(9999, 9999)

var direction = 0

@onready var label: Label = $Label
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dayS:bool = true
var isMoving:bool = true
var isDashing:bool = false
var isHurt:bool = false
var timeInAir:float = 0
var isAirDropping:bool = false
var isDying: bool = false

var idleAnim:String = "idle"
var runAnim:String = "run"
var jumpAnim:String = "jump_up"
var hurtAnim:String = "hurt"
@onready var dash_component: DashComponent = $DashComponent
func _ready():
	initialize_playerProperties()
	
	#set_base_stats()
	#apply_stat_modifiers()

func _physics_process(delta: float) -> void:
	#table for 
	#Dash Cooldown
	check_life()
	PlayerProperties.player_position = global_position
	label.text = "Velocityd.x = %d \nVelocity.y = %d \nCurrentSpeed = %d" % [velocity.x, velocity.y, player_properties.current_speed]
	#label.text = "is air dropping = %s" % [isAirDropping]
	# Add the gravity.
	if not is_on_floor():
		if not isDashing:
			velocity += get_gravity() * delta * player_properties.gravity_modifier
		timeInAir += delta
	else:
		timeInAir = 0
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or timeInAir < 0.2) and isMoving and !PlayerProperties.disable_jump:
		PlayerProperties.disable_jump = true
		velocity.y = player_properties.JUMP_VELOCITY
		jump.play()
		get_tree().create_timer(0.2).timeout.connect(func(): PlayerProperties.disable_jump = false)
		

	
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
				#get_tree().create_timer(walk_sound_timer).timeout.connect(Callable(self, "walk_sounds"))
		else:
			animated_sprite_2d.play(jumpAnim)
	
	if direction > 0:
		animated_sprite_2d.flip_h = true
	elif direction < 0:
		animated_sprite_2d.flip_h = false
	
	
		
	if direction and isMoving:
		if Input.is_action_pressed("sprint") and is_on_floor():
			if velocity.x * direction < 0:
				velocity.x = move_toward(velocity.x, direction * player_properties.current_speed, player_properties.SPEED_DELTA)
			elif abs(velocity.x) <= player_properties.MAX_SPEED:
				velocity.x += player_properties.ACCELERATION * direction
		else:
			#if abs(velocity.x) >= PlayerProperties.MAX_SPEED:
				#velocity.x = move_toward(velocity.x, PlayerProperties.MAX_SPEED, player_properties.SPEED_DELTA)
			if abs(velocity.x) > PlayerProperties.current_speed:
				velocity.x = move_toward(velocity.x, direction * player_properties.current_speed, 8)
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
	isHurt = false
	isDying = false
	self.set_collision_layer(PlayerProperties.player_collision_layer)
	print("player layer 2:", self.get_collision_layer_value(2))
	print("player layer 1:" ,self.get_collision_layer_value(1))
	player_health = PlayerProperties.PLAYER_BASE_HEALTH
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
	if !isHurt:
		animated_sprite_2d.play(hurtAnim)
		hurt.play()
	print("damage taken by player, current hp: ", player_health)
	
func walk_sounds():
	walk.play()

func check_life():
	if player_health <= 0:
		animated_sprite_2d.play("dead")
		if !isDying:
			isHurt = true
			isDying = true
			get_tree().create_timer(2).timeout.connect(func():
				if spawnPoint == Vector2(9999, 9999):
					get_tree().reload_current_scene()
				else:
					initialize_playerProperties()
					position = spawnPoint
					spawnPoint = Vector2(9999, 9999)
				)
		
		
	

func call_cauldron_menu():
	%UIManager.call_cauldron_menu()
	
func close_cauldron_menu():
	%UIManager.close_cauldron_menu()

func _set_isHurt():
	if !isHurt:
		isHurt = true
		var timer = get_tree().create_timer(0.7)
		timer.timeout.connect(func(): isHurt = false)

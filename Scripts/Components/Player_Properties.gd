extends Node
class_name Player_Properties
signal UIInfo
signal UpdateTown

#consts
const CONST_JUMP_VELOCITY = -350.0

#in player.dg get values from Player_Properties Class
@export_category("Base Player Values")
@export var BASE_SPEED = 150.0
@export var PLAYER_BASE_HEALTH = 100
@export var JUMP_VELOCITY = CONST_JUMP_VELOCITY
@export var ACCELERATION = 5.0
@export var SPEED_DELTA = 20.0
@export var MAX_SPEED = 500.0
@export var BASE_GRAVITY = 1.3
@export_category("Player Modifiers")
@export var air_dash: bool
@export var disable_jump: bool = false
@export var current_speed = BASE_SPEED
@export var player_current_base_health = 100
@export var gravity_modifier = BASE_GRAVITY
@export_category("Player Inventory")
@export var player_money: int = 0

@export_category("Player Un-saved inventory")
@export var money_found: int =  0
@export var water_quality_change: int = 0
@export var villager_happiness_change: int = 0
@export var population_health_change: int = 0
@export var chaos_change: int = 0
@export var good_change: int = 0

@export var player_collision_layer: int = 2

@export_category("Erasure Toggles")
@export var water_toggle: bool = false
@export var people_toggle: bool = false
@export var prosperity_toggle: bool = false

var player_position: Vector2 = Vector2.ZERO


func _set_air_dash(toggle: bool):
	air_dash = toggle

func _set_current_speed(boost: float):
	current_speed = current_speed * boost

func _set_temporary_speed_change(value: float, duration: float):
	current_speed *= value
	#get_tree().create_timer(duration).timeout.connect(set.bind("current_speed", current_speed/value))
	get_tree().create_timer(duration).timeout.connect(func():
		current_speed /= value
		)

func _level_complete(rewards: Player_Properties):
	pass
	#player_currency += rewards.money_found
#	
#	UIInfo.emit(rewards)
#	UpdateTown.emit(rewards)

func _level_start():
	money_found = 0
	water_quality_change = 0
	villager_happiness_change = 0
	population_health_change = 0
	chaos_change = 0
	good_change = 0
	

	
#On Signal for in_level_change
#
	
	
	

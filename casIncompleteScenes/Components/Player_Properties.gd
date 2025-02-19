extends Node
class_name Player_Properties
signal UIInfo
signal UpdateTown
#in player.dg get values from Player_Properties Class
@export_category("Base Player Values")
const BASE_SPEED = 150.0
const PLAYER_BASE_HEALTH = 100
const JUMP_VELOCITY = -350.0
const ACCELERATION = 5.0
const SPEED_DELTA = 20.0
const MAX_SPEED = 500.0
@export_category("Player Modifiers")
@export var air_dash: bool
@export var current_speed = BASE_SPEED
@export var player_current_base_health = 100
@export_category("Player - Other")
@export var player_money:int = 0

var isWorking = "Yes, its working"


func _set_air_dash(toggle: bool):
	air_dash = toggle

func _set_current_speed(boost: float):
	current_speed = current_speed * boost

func _level_complete(rewards: Player_Properties):
	pass
	#player_currency += rewards.money_found
#	
#	UIInfo.emit(rewards)
#	UpdateTown.emit(rewards)

	
#On Signal for in_level_change
#
	
	
	

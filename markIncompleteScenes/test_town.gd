extends Node2D
signal timeOfDayCycle
@export_category("Time of Day")
@export_enum("MORNING", "NOON", "NIGHT") var time_of_day = "MORNING"
#Simple to implement
@export_category("City Health")
@export_range(0,100,0.1) var water_quality : float
@export_range(0,100,0.1)var villager_happiness: float
@export_range(0,100,0.1) var population_health: float
@export_subgroup("Player alignment")
@export_range(0,100,0.1) var chaos: float
@export_range(0,100,0.1) var good: float
@export_enum("GOOD", "CHAOS", "NEUTRAL") var player_alignment = "NEUTRAL"
@export_subgroup("Complex Undefined City Health Systems")
@export_range(0,100,0.1) var admin: float
@export_range(0,100,0.1) var emergency_services: float
@export_range(0,100,0.1) var gdp: float #May need an array or Vector2D

var game_seed = 1

#Create Array of NPC's. Instanciate x times and add to array

#Game data
var eventPool:Array = []
var decisionLog:Array = []



#_physics_process will not likely be used in its current state for the update system, this is a place holder for testing
func _physics_process(delta: float) -> void:
	var current_alignment = player_alignment #Store the current alignment
	_alignment_threshold_check()			 #Check if the alignment values meet the criteria for an update
	if current_alignment != player_alignment:#if the alignment has changed the method will update children nodes on the players new alignment
		_update_alignment()
	
func _alignment_threshold_check():
	if chaos >= 50 and good < 50:
		player_alignment = "CHAOS"
	elif good >= 50 and chaos < 50:
		player_alignment = "GOOD"
	else: pass
		
	
#Start new game
#Call required functions to wipe and set up the game
#Pull  events from the pool based on modulo division and add x amount to event pool

#Generate Seed value
func generate_game_seed():
	game_seed = randf()

func get_game_seed():
	return game_seed
	
#Save game

#Load game

#Decision log
#Store an array for all dicotomy decisions made in the game

func get_time_of_day():
	return time_of_day

func set_time_of_day(time):
	time_of_day = time
	
func advance_time():
	if time_of_day == "MORNING":
		set_time_of_day("NOON")
		emit_signal("time_of_day", "NOON")
	elif time_of_day == "NOON":
		set_time_of_day("NIGHT")
		emit_signal("time_of_day", "NIGHT")
	elif time_of_day == "NIGHT":
		set_time_of_day("MORNING")
		emit_signal("time_of_day", "MORNING")
	else: 
		print("advance_time error, setting to morning")
		set_time_of_day("MORNING")
		
		

#Signal Emitting to children for threshholds hit
func _update_alignment():
	for child in self.get_children():
		if child.has_method("alignment_update"):
			child.alignment_update(player_alignment)



func _get_water_quality():
	return water_quality 
func _set_water_quality(water):
	pass
func _get_villager_happiness():
	return villager_happiness
func _set_villager_happiness(happy):
	pass
func _get_population_health():
	return population_health
func _set_population_health(health):
	pass
func _get_chaos():
	return chaos
func _set_chaos(chaos):
	pass
func _get_good():
	return good
func _set_good(good):
	pass
func _get_admin():
	return admin
func _set_admin(admin):
	pass
func _get_emergency_services():
	return emergency_services
func _set_emergency_services(emerg):
	pass
#May need to be a more complex data type, research required before creating.
func _get_gpd():
	return gdp
func _set_gdp(gdp):
	pass

func _get_eventPool():
	return eventPool
func _set_eventPool(event):
	pass
func _get_decisionLog():
	return decisionLog
func _set_decisionLog(log):
	pass	
#Create Array of NPC's. Instanciate x times and add to array

extends Node2D
signal timeOfDayCycle
var time_of_day = "morning"
#Simple to implement
var water_quality: int = 100
var villager_happiness: int = 100
var population_health: int = 100
var chaos: int = 0
var good: int = 0
#Complex
var admin: int = 100
var emergency_services: int = 100
var gdp: int = 100 #May need an array or Vector2D

var game_seed = 1

#Create Array of NPC's. Instanciate x times and add to array

#Game data
var eventPool:Array = []
var decisionLog:Array = []


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
	if time_of_day == "morning":
		set_time_of_day("noon")
		emit_signal("time_of_day", "noon")
	elif time_of_day == "noon":
		set_time_of_day("night")
		emit_signal("time_of_day", "night")
	elif time_of_day == "night":
		set_time_of_day("morning")
		emit_signal("time_of_day", "morning")
	else: 
		print("advance_time error, setting to morning")
		set_time_of_day("morning")
		

func update_town_stats(data: Dictionary):
	print("update_town_stats triggered. now we can sleep")
	if data.has("water_quality"):
		water_quality += data["water_quality"]
	if data.has("villager_happiness"):
		villager_happiness += data["villager_happiness"]
	if data.has("population_health"):
		population_health += data["population_health"]
	if data.has("chaos_change"):
		chaos += data["chaos_change"]
	if data.has("good_change"):
		good += data["good_change"]

func _get_water_quality():
	pass
func _set_water_quality(water):
	pass
func _get_villager_happiness():
	pass
func _set_villager_happiness(happy):
	pass
func _get_population_health():
	pass
func _set_population_health(health):
	pass
func _get_chaos():
	pass
func _set_chaos(chaos):
	pass
func _get_good():
	pass
func _set_good(good):
	pass
func _get_admin():
	pass
func _set_admin(admin):
	pass
func _get_emergency_services():
	pass
func _set_emergency_services(emerg):
	pass
#May need to be a more complex data type, research required before creating.
func _get_gpd():
	pass
func _set_gdp(gdp):
	pass
	
func _get_eventPool():
	pass
func _set_eventPool(event):
	pass
func _get_decisionLog():
	pass
func _set_decisionLog(log):
	pass	
#Create Array of NPC's. Instanciate x times and add to array

extends Area2D
signal playerInGoal(data: Dictionary)

func _ready():
	add_to_group("Goal")
	connect("body_entered", Callable(self, "_on_body_entered"))
	

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		var temp_data = {
			"gold": body.money_found,
			"water_quality": body.water_quality_change,
			"villager_happiness": body.villager_happiness_change,
			"population_health": body.population_health_change,
			"chaos_change": body.chaos_change,
			"good_change": body.good_change
			}
		emit_signal("playerInGoal", temp_data)
		print("Goal area triggered, entered by ", body," data sent: ",temp_data)

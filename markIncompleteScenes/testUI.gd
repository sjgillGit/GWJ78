extends Label
@onready var label: Label = $"."

func _ready():
	for goal in get_tree().get_nodes_in_group("goal"):
		if not goal.is_connected("playerInGoal", Callable(self, "_on_goal_reached")):
			var error = goal.connect("playerInGoal", Callable(self, "_on_goal_reached"))
			if error == OK:
				print("goal signal connected to player")
			else:
				print("failed to connect goal group signal to player")

func _on_goal_reached(data: Dictionary):
	print("on_goal_reached triggered in testUI.gd")
	label.text = ("Level Results: "+ str(data))

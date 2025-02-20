extends Node2D
@onready var mugger_spawn: PathFollow2D = $"mugger spawn/PathFollow2D"

func _ready() -> void:
	Town.chaos += 6
	
	spawn_mob()

func spawn_mob():
	for i in Town.chaos:
		var new_mob = preload("res://markIncompleteScenes/mugger.tscn").instantiate()
		mugger_spawn.progress_ratio = randf()
		new_mob.global_position = mugger_spawn.global_position
		add_child(new_mob)

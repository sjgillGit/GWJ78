extends Path2D
@onready var path_follow_2d: PathFollow2D = $PathFollow2D

func _ready() -> void:
	Town.chaos += 2
	spawn_mob()

func spawn_mob():
	for i in range(Town.chaos):
		var new_mob = preload("res://markIncompleteScenes/mugger.tscn").instantiate()
		
		path_follow_2d.progress_ratio = randf()
		new_mob.position = path_follow_2d.position
		add_child(new_mob)

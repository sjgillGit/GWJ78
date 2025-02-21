class_name nextLevel
extends Area2D
@export_category("Map Next level")
var next_level: Node2D
@export var level_name: String = "debug_world_1"
const FILE_BEGIN = "res://markIncompleteScenes/levels/" #use this if the files are done with numbers at the end
#var current_scene_file = get_tree().current_scene.scene_file_path
#var next_level_number = current_scene_file.to_int() +1
#var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
#get_tree().change_scene_to_file(next_level_path)
#this can be used if the way to enter levels is done static, then this can work fluid after
func _ready():
	initialize_player_properties()
	#print(current_scene_file)

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Scenes/levels/"+ level_name +".tscn")

func initialize_player_properties():
	set_collision_mask(PlayerProperties.player_collision_layer)
	#print("goal collision mask", get_collision_mask_value(PlayerProperties.player_collision_layer))
	#add_to_group("goal")
	var debug = get_groups()
	print("next_level_transition in group: ",debug)
	connect("body_entered", Callable(self, "_on_body_entered"))

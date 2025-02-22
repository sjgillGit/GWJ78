extends Node2D

@onready var top_hidden: TileMapLayer = $TileSets/Hive/JumpPadRoom/HiddenRoom
@onready var bot_hidden: TileMapLayer = $TileSets/Hive/JumpPadRoom/HiddenRoom2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		top_hidden.visible = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		top_hidden.visible = true


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		bot_hidden.visible = false


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		bot_hidden.visible = true

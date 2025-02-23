extends Node2D

@onready var top_hidden: TileMapLayer = $TileSets/Hive/JumpPadRoom/HiddenRoom
@onready var bot_hidden: TileMapLayer = $TileSets/Hive/JumpPadRoom/HiddenRoom2
@onready var jump_hive: Node2D = $jump_hive
@onready var swings: Node2D = $Swings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerProperties.water_toggle = true
	if PlayerProperties.water_toggle == true:
		print("water toggle triggered on readyin ", self)
		jump_hive.queue_free()
	if PlayerProperties.people_toggle == true:
		print("people_toggle triggered on ready in ", self)
		jump_hive.queue_free()
	if PlayerProperties.prosperity_toggle == true:
		swings.queue_free()
		print("prosperity_toggle triggered on ready in ", self)


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

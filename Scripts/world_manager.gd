extends Node2D
@onready var water_layer: TileMapLayer = $water_toggle
@onready var people_layer: TileMapLayer = $people_toggle
@onready var prosperity_layer: TileMapLayer = $prosperity_toggle
#onready var mugger_spawn: Path2D = $"mugger spawn"

func _ready() -> void:
	if PlayerProperties.water_toggle == true:
		print("water toggle triggered on readyin ", self)
		water_layer.queue_free()
	if PlayerProperties.people_toggle == true:
		print("people_toggle triggered on ready in ", self)
		people_layer.queue_free()
	if PlayerProperties.prosperity_toggle == true:
		prosperity_layer.queue_free()
		print("prosperity_toggle triggered on ready in ", self)
	

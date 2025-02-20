extends StaticBody2D
@onready var player: CharacterBody2D = $"../Player"
@export_range(0, 90, 0.1, "radians_as_degrees") var angle:float
@export var swingDuration:float = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = angle
	swing()
	pass

func swing(swingLeft:bool = true):
	var tween = create_tween()
	if swingLeft:
		tween.tween_property(self, "rotation", angle*-1, swingDuration).from_current()
	else:
		tween.tween_property(self, "rotation", angle, swingDuration).from_current()
	tween.tween_callback(swing.bind(!swingLeft))

func _process(delta: float) -> void:
	#player.label.text = str(rotat)
	pass

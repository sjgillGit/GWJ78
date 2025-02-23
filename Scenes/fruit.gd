extends Area2D
@export_category("Fruit ID")
@export var fruit_id: int
#var fruit_index = str("fruit",fruit_id)
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if PlayerProperties.fruits_collected.get(str(fruit_id),false):
		queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body._pickup_sound()
		audio_stream_player_2d.play()
		PlayerProperties.fruits_collected[str(fruit_id)] = true
		#animation_player.play("collect")
		queue_free()

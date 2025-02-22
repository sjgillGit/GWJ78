extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var disable: bool = false
@export var boost: float = 260
var boost_curr: float
@export_enum("Forest", "Hive") var type: String = "Forest"

func _ready() -> void:
	boost_curr = boost
	animated_sprite_2d.play(str(type, "_idle"))
	if disable:
		visible = false
		collision_shape_2d.disabled = true
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !disable:
		audio_stream_player_2d.play()
		boost_curr = boost
		var space_state:PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		var parameters := PhysicsRayQueryParameters2D.create(area_2d.global_position, body.global_position, 2)
		var collision: Dictionary = space_state.intersect_ray(parameters)
		if !collision.is_empty():
			if collision.normal.y >= 0:
				if body.isAirDropping:
					boost_curr *= 1.5
				body.velocity.y = boost_curr * -1
				animated_sprite_2d.play(type)

func _on_interact():
	disable = false
	visible = true
	collision_shape_2d.disabled = false

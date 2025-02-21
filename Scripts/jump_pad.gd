extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var boost: float = 260
@export_enum("Forest", "Hive") var type: String = "Forest"

func _ready() -> void:
	animated_sprite_2d.play(str(type, "_idle"))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var space_state:PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		var parameters := PhysicsRayQueryParameters2D.create(area_2d.global_position, body.global_position, 2)
		var collision: Dictionary = space_state.intersect_ray(parameters)
		print(collision)
		if !collision.is_empty():
			if collision.normal.y >= 0:
				body.velocity.y = boost * -1
				animated_sprite_2d.play(type)

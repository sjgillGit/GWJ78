extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			PlayerProperties.disable_jump = true
			PlayerProperties.gravity_modifier = 0.5
			PlayerProperties.JUMP_VELOCITY = 0
			PlayerProperties._set_temporary_speed_change(0.2, 0.7)
			get_tree().create_timer(0.7).timeout.connect(func():
				PlayerProperties.gravity_modifier = PlayerProperties.BASE_GRAVITY
				PlayerProperties.JUMP_VELOCITY = PlayerProperties.CONST_JUMP_VELOCITY
				PlayerProperties.disable_jump = false
				)
			body.take_damage()
			body.velocity.y = -260
			body.move_and_slide()

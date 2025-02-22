extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("reload scene")
	#-2000, -16
		get_tree().reload_current_scene()
	#queue_free()

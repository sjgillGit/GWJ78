extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.add_gold(1) # Replace with function body.
	queue_free()

extends Area2D
signal UpdateTown
signal EndScreenResults


func _on_body_entered(body: Node2D) -> void:

	UpdateTown.emit()

extends Area2D
var player_in_range: bool = false
var saved_body
@onready var timer: Timer = $"../Timer"

func _ready():
	pass
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		print("Player Group in hurtbox. Sent from Hitbox node")
		saved_body = body
	


func _on_timer_timeout() -> void:
	print(saved_body," was recorded, and attempting to trigger damage")
	if player_in_range:
		if saved_body.has_method("take_damage"):
			saved_body.take_damage()
			print(saved_body," damage method called")


func _on_body_exited(body: Node2D) -> void:
	player_in_range = false

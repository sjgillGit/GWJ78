extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var marker_2d: Marker2D = $Marker2D
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var area_2d: Area2D = $Area2D
@onready var area_2d_2: Area2D = $Area2D2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if player.isMoving:
		player.isMoving = false
		var tween = create_tween()
		var playerTween = create_tween()
		playerTween.tween_property(player, "position:x", area_2d_2.position.x + 30, 1)
		tween.tween_property(camera_2d, "position:x", marker_2d_2.position.x, 1.2)
		tween.finished.connect(player.set.bind("isMoving", true))


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if player.isMoving:
		player.isMoving = false
		var tween = create_tween()
		var playerTween = create_tween()
		playerTween.tween_property(player, "position:x", area_2d.position.x - 30, 1)
		tween.tween_property(camera_2d, "position:x", marker_2d.position.x, 1.2)
		tween.finished.connect(player.set.bind("isMoving", true))

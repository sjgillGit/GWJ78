extends Area2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var windStrength:float = 50

var bodyInArea: CharacterBody2D = null
var areaStart: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if bodyInArea:
		var posDiff = (bodyInArea.global_position.x + bodyInArea.get_node("CollisionShape2D").shape.radius) - areaStart
		if posDiff > 0:
			bodyInArea.velocity.x -= windStrength
			


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
	#if body.is_in_group("player"):

		areaStart = collision_shape_2d.global_position.x - collision_shape_2d.shape.size.x/2
		bodyInArea = body


func _on_body_exited(body: Node2D) -> void:
	if body == bodyInArea:
		bodyInArea = null

extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var texture:Texture
@export var connectedObject:Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.hide()
	if texture:
		sprite_2d.texture = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if connectedObject:
		if Input.is_action_just_pressed("interact"):
			if connectedObject.has_method("_on_interact"):
				connectedObject._on_interact()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		label.hide()

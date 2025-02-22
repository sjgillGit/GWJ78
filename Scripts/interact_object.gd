extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var texture:Texture
@export var connectedObject:Array[Node2D]
@export var labelText:String = "Press E to interact"

var inArea: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = labelText
	label.hide()
	if texture:
		sprite_2d.texture = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if connectedObject and inArea:
		if Input.is_action_just_pressed("interact"):
			for object in connectedObject:
				if object.has_method("_on_interact"):
					object._on_interact()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inArea = true
		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		inArea = false
		label.hide()

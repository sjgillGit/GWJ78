extends CharacterBody2D
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var chat_box: Label = $Label
@onready var chat_timer: Timer = $Timer
signal isWalking
var isTalking: bool = false
var show_npc_text
@export_category("Player Properties")
@export var movement_speed: int = 500

func _ready():
	animation.play_idle()
	
func _physics_process(delta: float) -> void:
	if !isTalking:
		if Input.is_action_just_pressed("interact"):
			debug_npc_chat()
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		velocity = direction * movement_speed
		move_and_slide()
	
	if velocity.length() > 0.0:
		animation.play_walk()
		isWalking.emit()
	else:  
		animation.play_idle()
		
func _on_is_walking() -> void:
	if velocity.x < 0:
		animation.flip_h = true
	elif velocity.x > 0:
		animation.flip_h = false

func debug_npc_chat():
	chat_box.set_visible(true)
	chat_timer.start()
	
func _on_interactable_on_interact(text) -> void:
		chat_box.set_text(text)

func _on_timer_timeout() -> void:
	chat_box.set_visible(false)

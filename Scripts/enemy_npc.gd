extends CharacterBody2D
@export var health:int = 1
var isDead:bool = false
@export var speed: float = 100.0
var isAttacking: bool = false
var player_in_range: bool = false
#var wait_time = 1 #how long the attack animation and hurtbox will last
@onready var hurtbox: Area2D = $Hurtbox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var lag_timer: Timer = $lagTimer

func _ready() -> void:
	hurtbox.set_collision_mask_value(PlayerProperties.player_collision_layer, true)
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 2
	var distance = global_position.distance_to(PlayerProperties.player_position)
	if !isAttacking and distance <= 150:
		var playerPathing = global_position.direction_to(PlayerProperties.player_position) #where THIS mob is in the world (works with sprite or characterBody2D) direction_to
		velocity.x = playerPathing.x * 10.00
		change_Sprite_Direction()
		move_and_slide()
	else: animated_sprite_2d.play("idle")
	


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("Player Group in hurtbox. Sent from mugger parent node")
	if body.is_in_group("player"):
		print("Player validated Group in hurtbox. Sent from mugger parent node")
		isAttacking = true
		player_in_range = true
		hurtbox.set_process(true)
		animated_sprite_2d.play("attack")
		while player_in_range:
			timer.start()
			await timer.timeout

		
func check_life():
	if isDead:
		var wait_time = 0.3
		$AnimatedSprite2D.play_death()
		await get_tree().create_timer(wait_time).timeout
		queue_free()
		
func _on_timer_timeout() -> void:
	if !player_in_range:
		isAttacking = false
		hurtbox.set_process(false)
	
func change_Sprite_Direction():
	if velocity.x < 0: #Look Left
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk")
	elif velocity.x > 0: #Look Right
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walk")
	else: animated_sprite_2d.play("idle")


func _on_hurtbox_body_exited(body: Node2D) -> void:
	player_in_range = false

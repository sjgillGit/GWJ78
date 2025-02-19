class_name StealthComponent
extends Node

@export var characterBody:CharacterBody2D
@export var player_properties:PlayerProperties
@export var duration:float = 4.0
@export var stealthStrength = 0.6

var isInStealth = false

func stealth():
	get_tree().create_timer(duration).timeout.connect(_on_stealth_end)
	print("Start of Stealth")
	isInStealth = true
	player_properties._set_temporary_speed_change(stealthStrength, duration)

func _on_stealth_end():
	isInStealth = false
	print("End of stealth")


func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Stealth_Skill"):
		stealth()

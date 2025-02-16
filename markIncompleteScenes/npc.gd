extends CharacterBody2D
#pull text from Json, parse
#rng on seed to select dialog, and add to dialog options array
var dialog_pool:Array = []
var testText = "IT WORKED"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export_category("NPC Properties")
@export_enum("NEUTRAL", "CHAOS", "GOOD") var player_alignment = "NEUTRAL"
var sprite_display_aligner = "idle"
signal passText

func _ready():
	#for child in self.get_children():
	#	if child.has_method("set_text"):
	#		child.set_text(testText)
	pass
	
func _physics_process(delta: float) -> void:
	check_alignment_status()
	animated_sprite_2d.play(sprite_display_aligner)

			
func alignment_update(alignmnet):
	player_alignment = alignmnet
	print(player_alignment)
	
func check_alignment_status():
	if player_alignment == "CHAOS":
		sprite_display_aligner = "chaos"
		print("Alignment Check - CHAOS - Updating sprite to chaos")
	elif player_alignment == "GOOD":
		sprite_display_aligner = "good"
		print("Alignment Check - GOOD - Updating sprite to GOOD")
	else: 
		sprite_display_aligner = "idle"
		print("Alignment Check - "+ sprite_display_aligner + " " + player_alignment + " - Not updating sprite")
		
		

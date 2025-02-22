extends CanvasLayer

signal on_transmition_finished

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _onready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func transtition():
	color_rect.visible = true
	animation_player.play("fade_to_black")
	
func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transmition_finished.emit()
		animation_player.play("fade_out")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
		

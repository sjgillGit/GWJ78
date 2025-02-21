extends Control
var cauldron_interface_active = false
var humans_erased = false
var water_erased = false
var prosperity_erased = false

var humans_are_erased_flavor_text = 'The humans of this land have been wiped out by a mysterious force'
var humans_are_not_erased_flavor_text = 'Click to erase the humans of this land'
var water_is_erased_flavor_text = 'All the water has dried up due to a mysterious force'
var water_is_not_erased_flavor_text = 'Click to erase the water of this land'
var prosperity_is_erased_flavor_text = 'This land has had all of it\'s money erased'
var prosperity_is_not_erased_flavor_text = 'Click to erase the prosperity of this land'

signal cauldron_interface_toggle
signal cauldron_interface_closed
signal humans_button_pressed
signal water_button_pressed
signal prosperity_button_pressed

func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func show_options():
	%RemoveHumans.grab_focus()
	cauldron_interface_active = true
	show()
	cauldron_interface_toggle.emit(cauldron_interface_active)
	


func _on_remove_humans_pressed() -> void:
	humans_erased = not humans_erased
	if (humans_erased):
		humans_button_pressed.emit(humans_are_erased_flavor_text)
	else:
		humans_button_pressed.emit(humans_are_not_erased_flavor_text)


func _on_remove_water_pressed() -> void:
	water_erased = not water_erased
	if (water_erased):
		water_button_pressed.emit(water_is_erased_flavor_text)
	else:
		water_button_pressed.emit(water_is_not_erased_flavor_text)


func _on_remove_prosperity_pressed() -> void:
	prosperity_erased = not prosperity_erased
	if (prosperity_erased):
		prosperity_button_pressed.emit(prosperity_is_erased_flavor_text)
	else:
		prosperity_button_pressed.emit(prosperity_is_not_erased_flavor_text)

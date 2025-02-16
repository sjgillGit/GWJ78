extends CharacterBody2D
#pull text from Json, parse
#rng on seed to select dialog, and add to dialog options array
var dialog_pool:Array = []
var testText = "IT WORKED"
signal passText

func _ready():
	for child in self.get_children():
		if child.has_method("set_text"):
			child.set_text(testText)

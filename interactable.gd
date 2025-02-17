extends Area2D
signal on_interact
var interact_range: bool = false
var testDialogue = "didnt work :("

#func _interact():
	#if interact_range == true:
		#emit_signal("on_interact", testDialogue)

func set_text(text):
	print("parent triggered child")
	testDialogue = text

func _on_body_entered(body: Node2D) -> void:
	print("Hello, walking a little close arent we?")
	interact_range = true
	emit_signal("on_interact", testDialogue)


func _on_body_exited(body: Node2D) -> void:
	#print("bye")
	interact_range = false
	emit_signal("on_interact", "")

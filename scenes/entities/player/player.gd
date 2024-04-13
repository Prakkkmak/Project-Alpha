extends CharacterBody2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dialog_open"):
		Dialogic.start('first_timeline')
		get_viewport().set_input_as_handled()
		

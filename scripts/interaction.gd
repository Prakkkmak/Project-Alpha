class_name Interaction extends Resource

signal ended
signal failed
signal resolved

@export var condition: String

func perform_interaction(_source: Area2D, _target: Area2D) -> void:
	pass



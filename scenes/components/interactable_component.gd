@tool
class_name InteractableComponent extends Area2D

@export var interaction: Interaction


func interact(source: Area2D) -> void:
	if !interaction:
		return
	interaction.call("perform_interaction", source, self)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	if !interaction:
		warnings.append("No interaction set")
	return warnings

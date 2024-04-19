class_name InteractionComponent extends Area2D

signal interaction_ended

var nearby_interactables: Array[Area2D] = []

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func interact() -> void:
	if get_interacted_object():
		get_interacted_object().call("interact", self)
		(get_interacted_object() as InteractableComponent).interaction.ended.connect(_on_interationc_ended)


func get_interacted_object() -> Area2D:
	if nearby_interactables.size() > 0:
		return nearby_interactables[0]
	return null


func _on_area_entered(area: Area2D) -> void:
	if area is InteractableComponent:
		nearby_interactables.append(area)
		area.call("show_interact_key", true)


func _on_area_exited(area: Area2D) -> void:
	if area in nearby_interactables:
		nearby_interactables.erase(area)
		area.call("show_interact_key", false)


func _on_interationc_ended() -> void:
	interaction_ended.emit()

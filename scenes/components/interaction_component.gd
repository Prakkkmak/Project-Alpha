extends Area2D


var nearby_interactables: Array[Area2D] = []


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact()


func interact() -> void:
	print("Try to interact")
	if get_interacted_object():
		print("Interact with first interacted object")
		get_interacted_object().call("interact", self)


func get_interacted_object() -> Area2D:
	if nearby_interactables.size() > 0:
		return nearby_interactables[0]
	return null


func _on_area_entered(area: Area2D) -> void:
	if area is InteractableComponent:
		print("InteractableComponent added to nearby interactables")
		nearby_interactables.append(area)


func _on_area_exited(area: Area2D) -> void:
	if area in nearby_interactables:
		print("InteractableComponent deleted from nearby interactables")
		nearby_interactables.erase(area)

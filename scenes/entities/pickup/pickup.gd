extends Node2D

@export var pickup: PickupData
@export var show_hint: bool = true
@export var condition: String


@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	print(pickup.name + "_acquired")
	print(GameState.has_key(pickup.name + "_acquired"))
	if GameState.has_key(pickup.name.to_lower() + "_acquired"):
		queue_free()
	if !pickup:
		return
	sprite.texture = pickup.world_texture
	if interactable_component.interaction is PickupInteraction:
		(interactable_component.interaction as PickupInteraction).pickup = pickup
		(interactable_component.interaction as PickupInteraction).ended.connect(queue_free)
	interactable_component.show_interact_key_on_hover = show_hint
	interactable_component.set_condition(condition)

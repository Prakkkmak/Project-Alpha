extends Node2D

@export var pickup: PickupData
@export var show_hint: bool = true

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if !pickup:
		return
	sprite.texture = pickup.world_texture
	if interactable_component.interaction is PickupInteraction:
		(interactable_component.interaction as PickupInteraction).pickup = pickup
	interactable_component.show_interact_key_on_hover = show_hint
	

extends StaticBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var interactable_component: InteractableComponent = %InteractableComponent


func _ready() -> void:
	interactable_component.interaction_resolved.connect(_on_event_resolved)


func _on_event_resolved() -> void:
	animated_sprite_2d.animation_finished.connect(queue_free)
	animated_sprite_2d.play("die")

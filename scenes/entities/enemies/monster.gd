extends StaticBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var interactable_component: InteractableComponent = %InteractableComponent


func _ready() -> void:
	if GameState.get_state("monster_defeated"):
		queue_free()
	animated_sprite_2d.play("idle")
	interactable_component.interaction_resolved.connect(_on_event_resolved)


func _on_event_resolved() -> void:
	interactable_component.queue_free()
	animated_sprite_2d.play("die")
	animated_sprite_2d.animation_looped.connect(queue_free)

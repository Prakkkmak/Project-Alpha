class_name InteractState extends State


@export var interaction_component: InteractionComponent


@export_group("Next States")
@export var idle_state: State

var process_input: bool = false


func _enter() -> void:
	if !interaction_component:
		transition_to(idle_state)
		return
	interaction_component.interaction_ended.connect(_on_interaction_ended)
	print("Interact")
	interaction_component.interact()
	print("Interact completed")


func _on_interaction_ended() -> void:
	transition_to(idle_state)

extends CharacterBody2D


@onready var move_component: MoveComponent = $MoveComponent
@onready var interaction_component: Area2D = $InteractionComponent
@onready var interaction_distance: float = interaction_component.position.length()



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dialog_open"):
		Dialogic.start('first_timeline')
		get_viewport().set_input_as_handled()


func _physics_process(delta: float) -> void:
	var new_interaction_component_position: Vector2 = move_component.get_direction() * interaction_distance
	if new_interaction_component_position.length() > 0:
		interaction_component.position = new_interaction_component_position

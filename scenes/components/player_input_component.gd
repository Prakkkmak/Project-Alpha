@tool
extends Node


@export var _move_component: MoveComponent


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if !_move_component:
		return
	var direction: Vector2 = get_direction_input()
	_move_component.set_direction(direction)


func get_direction_input() -> Vector2:
	var x_movement : float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement : float = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)


func _get_configuration_warnings() -> PackedStringArray:
	if !_move_component:
		return ['VelocityComponent missing']
	return []

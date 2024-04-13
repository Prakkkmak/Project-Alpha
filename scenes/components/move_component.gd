@tool
class_name MoveComponent extends Node


@export var _max_speed: float = 70
@export var _acceleration: float = 20
@export var _character_body: CharacterBody2D


var _velocity: Vector2 = Vector2.ZERO
var _direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if !_character_body:
		return
	_velocity = _velocity.lerp(_direction * _max_speed, 1 - exp(-_acceleration * delta))
	_character_body.velocity = _velocity
	_character_body.move_and_slide()
	_velocity = _character_body.velocity



func set_character_body(character_body: CharacterBody2D) -> void:
	_character_body = character_body


func set_direction(direction: Vector2) -> void:
	_direction = direction


func get_direction() -> Vector2:
	return _direction


func _get_configuration_warnings() -> PackedStringArray:
	if !_character_body:
		return ['Character body not set']
	return []

extends Node

@export var end_screen: PackedScene
@export var end_condition: String = "crown_acquired"


func _ready() -> void:
	GameState.state_changed.connect(_on_state_changed)


func end_game() -> void:
	get_tree().change_scene_to_packed(end_screen)


func _on_state_changed(state: String, value: bool) -> void:
	if state == end_condition && value:
		end_game()

extends Node2D


@export var disapear_condition: String


func _ready() -> void:
	GameState.state_changed.connect(_on_game_state_changed)


func _on_game_state_changed(state: String, value: bool) -> void:
	if disapear_condition == state:
		queue_free()

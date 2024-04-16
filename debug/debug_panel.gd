extends PanelContainer

@onready var game_state_values_label: Label = $GameStateValuesLabel

func _ready() -> void:
	GameState.state_changed.connect(_on_state_changed)
	


func _on_state_changed(state: String, value: bool) -> void:
	game_state_values_label.text += "\n" + state + ":" + str(value)

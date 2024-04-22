class_name LevelDisplayer extends PanelContainer


@export var duration: float = 10.0
@export var transition_duration: float = 3.0

@onready var level_name: Label = %LevelName

func display_level(level_name_text: String) -> void:
	level_name.text = level_name_text
	modulate = Color.TRANSPARENT
	
	var tween: Tween = get_tree().create_tween()

	tween.tween_property(self, "modulate", Color.WHITE, transition_duration)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)

	tween.tween_interval(duration - (transition_duration * 2))

	tween.tween_property(self, "modulate", Color.TRANSPARENT, transition_duration)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)

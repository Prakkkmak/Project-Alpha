class_name OpenTimelineInteraction extends Interaction

@export var timeline: DialogicTimeline

func perform_interaction(source: Area2D, target: Area2D) -> void:
	Dialogic.start(timeline)

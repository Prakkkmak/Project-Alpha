class_name EventInteraction extends Interaction

@export var event_name: String
@export var timeline: DialogicTimeline

func perform_interaction(source: Area2D, target: Area2D) -> void:
	Dialogic.start(timeline)
	Dialogic.timeline_ended.connect(_on_timeline_ended, ConnectFlags.CONNECT_ONE_SHOT)
	

func _on_timeline_ended() -> void:
	GameState.set_state(event_name)
	ended.emit()

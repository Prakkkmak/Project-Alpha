class_name PickupInteraction extends Interaction

@export var pickup: PickupData

func perform_interaction(_source: Area2D, _target: Area2D) -> void:
	var timeline: DialogicTimeline = create_timeline()
	Dialogic.start(timeline)
	Dialogic.timeline_ended.connect(_on_timeline_ended, ConnectFlags.CONNECT_ONE_SHOT)


func create_timeline() -> DialogicTimeline:
	var events: Array = []
	var text_event: DialogicTextEvent = DialogicTextEvent.new()
	text_event.text = "You acquired: " + pickup.name.to_lower() + "!"
	text_event.character = load("res://resources/dialogic/characters/narrator.dch")
	events.append(text_event)
	var timeline : DialogicTimeline = DialogicTimeline.new()
	timeline.events = events
	# FIXME if your events are already resources, you need to add this:
	timeline.events_processed = true
	return timeline
	


func _on_timeline_ended() -> void:
	GameState.set_state(pickup.name.to_lower() + "_acquired")
	ended.emit()

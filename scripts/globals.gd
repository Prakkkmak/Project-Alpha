extends Node

const PLAYER_DIALOGIC_CHARACTER: DialogicCharacter = preload("res://resources/dialogic/characters/little_king.dch")

func create_timeline_text(text: String, character: DialogicCharacter = null) -> DialogicTimeline:
	var events: Array = []
	var text_event: DialogicTextEvent = DialogicTextEvent.new()
	text_event.text = text
	text_event.character = character
	events.append(text_event)
	var timeline : DialogicTimeline = DialogicTimeline.new()
	timeline.events = events
	timeline.events_processed = true
	return timeline

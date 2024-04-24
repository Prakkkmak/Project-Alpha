class_name PickupInteraction extends Interaction

@export var pickup: PickupData

func perform_interaction(_source: Area2D, _target: Area2D) -> void:
	var timeline: DialogicTimeline = Globals.create_timeline_text("You acquired: " + pickup.name.to_lower() + "!")
	Dialogic.start(timeline)
	Dialogic.timeline_ended.connect(_on_timeline_ended, ConnectFlags.CONNECT_ONE_SHOT)



func _on_timeline_ended() -> void:
	GameState.set_state(pickup.name.to_lower() + "_acquired")
	ended.emit()

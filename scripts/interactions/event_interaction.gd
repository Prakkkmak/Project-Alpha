class_name EventInteraction extends Interaction

@export var event_name: String
@export var timeline: DialogicTimeline
@export var resolve_timeline: DialogicTimeline
@export var failed_timeline: DialogicTimeline
@export var resolve_conditions: Array[TimelineCondition]
@export var delete_on_resolve: bool = true


var target_area: Area2D

func perform_interaction(_source: Area2D, target: Area2D) -> void:
	if !timeline:
		push_error("No timeline")
		ended.emit()
		return
	target_area = target
	if GameState.get_state(event_name):
		# Vérifie et lance immédiatement la timeline si les conditions sont remplies
		if not _launch_resolved_timeline():
			# Si aucune condition n'est remplie, rejouer la timeline de base
			Dialogic.start(timeline)
			Dialogic.timeline_ended.connect(_on_timeline_ended, ConnectFlags.CONNECT_ONE_SHOT)
	else:
		# Lancer la timeline de base pour la première fois
		Dialogic.start(timeline)
		Dialogic.timeline_ended.connect(_on_timeline_ended, ConnectFlags.CONNECT_ONE_SHOT)

func _on_timeline_ended() -> void:
	GameState.set_state(event_name)
	ended.emit()


func _launch_resolved_timeline() -> bool:
	for condition: TimelineCondition in resolve_conditions:
		if condition.are_conditions_met():
			Dialogic.start(condition.timeline)
			Dialogic.timeline_ended.connect(_on_ended_event, ConnectFlags.CONNECT_ONE_SHOT)
			GameState.set_state(condition.name + "_completed")
			return true  # Retourne vrai dès qu'une timeline est lancée
	return false  # Retourne faux si aucune condition n'est remplie


func _on_ended_event() -> void:
	if resolve_timeline:
		#FIXME Je crois que c'est a supprimer
		resolved.emit()
		ended.emit()
		if delete_on_resolve and target_area and target_area.get_parent() is Node2D:
			(target_area.get_parent() as Node2D).queue_free()
	else:
		_on_resolve_resolve_ended()
	


func _on_resolve_resolve_ended() -> void:
	ended.emit()
	resolved.emit()
	

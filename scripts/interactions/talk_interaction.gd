class_name TalkInteraction extends Interaction

@export var npc_data: NpcData

func perform_interaction(source: Area2D, target: Area2D) -> void:
	# Vérifie si le salut initial a déjà eu lieu
	var greeted_state_name: String = npc_data.name+ "_greeted"
	var greeted: bool = GameState.get_state(greeted_state_name)
	if not greeted:
		Dialogic.start(npc_data.greetings_timeline)
		Dialogic.timeline_ended.connect(_on_timeline_ended.bind(greeted_state_name), ConnectFlags.CONNECT_ONE_SHOT)
	else:
		for condition: TimelineCondition in npc_data.conditions:
			if condition.are_conditions_met():
				var state_name: String = npc_data.name + "_" + condition.timeline.get_name() + "_completed"
				Dialogic.start(condition.timeline)
				Dialogic.timeline_ended.connect(_on_timeline_ended.bind(state_name), ConnectFlags.CONNECT_ONE_SHOT)
				return
		# Si aucune condition n'est remplie, lancer la timeline de conversation par défault
		var talked_state_name: String = npc_data.name + "_talked"
		Dialogic.start(npc_data.talk_timeline)
		Dialogic.timeline_ended.connect(_on_timeline_ended.bind(talked_state_name), ConnectFlags.CONNECT_ONE_SHOT)

func _on_timeline_ended(state_to_update: String) -> void:
	GameState.set_state(state_to_update)
	ended.emit()
